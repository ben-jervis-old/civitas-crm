class MessagesController < ApplicationController
  
  def index
    @messages = current_user.received_messages
                    .order(created_at: :desc)
                    .paginate(:page => params[:page], :per_page => 30)
    @place = 'inbox'
  end
  
  def sent_messages
    @messages = current_user.sent_messages
                    .where(sent: true)
                    .order(created_at: :desc)
                    .paginate(:page => params[:page], :per_page => 30)
    
    @place = 'sent'
  end
  
  def draft_messages
    @messages = current_user.sent_messages
                    .where(sent: false)
                    .order(created_at: :desc)
                    .paginate(:page => params[:page], :per_page => 30)
    
    @place = 'draft'
  end

  def new
    @message = Message.new
    @messages = current_user.sent_messages
                    .where(sent: false)
                    .order(created_at: :desc)
                    .paginate(:page => params[:page], :per_page => 30)
    
    @place = 'draft'
    @users = User.all
    @groups = Group.all
  end
  
  def update
    @message = Message.find(params[:id])
    if params[:submit] == "Send Message" && params.has_key?(:recipients)
      @message.sent = true
      params[:recipients][:user_id].each  do |id|
        if id[0] == "U"
          id = id[1..-1]
          @recipient = User.find(id)
          @recipient.received_messages.create(title: @message.title,
                        content: @message.content,
                        sender: @message.sender,
                        receiver: @recipient,
                        sent: true)
          MessageMailer.new_message(@recipient.received_messages.last).deliver_now
        elsif id[0] == "G"
          id = id[1..-1]
          @group = Group.find(id)
          @group.memberships.each do |mem|
            @recipient = User.find(mem.user_id)
            @recipient.received_messages.create(title: @message.title,
                        content: @message.content,
                        sender: @message.sender,
                        receiver: @recipient,
                        sent: true)
          end
        end
      end
      @message.delete
      redirect_to action: 'sent_messages'
    elsif params[:submit] == "Save as Draft"
      @message.update_attributes(message_params)
      @message.updated_at = Time.now
      if @message.save
  			flash[:success] = "Message updated successfully"
      else
        flash[:success] = "Message not updated try again"
      end
      redirect_to :action => "edit", :id => @message.id
    end
  end
  
  def create
    @message = current_user.sent_messages.create(message_params)
    if params[:submit] == "Send Message" && params.has_key?(:recipients)
      @message.sent = true
      params[:recipients][:user_id].each  do |id|
        if id[0] == "U"
          id = id[1..-1]
          @recipient = User.find(id)
          @recipient.received_messages.create(title: @message.title,
                        content: @message.content,
                        sender: @message.sender,
                        receiver: @recipient,
                        sent: true)
          MessageMailer.new_message(@recipient.received_messages.last).deliver_now
        elsif id[0] == "G"
          id = id[1..-1]
          @group = Group.find(id)
          @group.memberships.each do |mem|
            @recipient = User.find(mem.user_id)
            @recipient.received_messages.create(title: @message.title,
                        content: @message.content,
                        sender: @message.sender,
                        receiver: @recipient,
                        sent: true)
          end
        end
      end
      @message.delete
      redirect_to action: 'sent_messages'
    elsif params[:submit] == "Save as Draft"
      @message.update_attributes(message_params)
      @message.updated_at = Time.now
      if @message.save
  			flash[:success] = "Message updated successfully"
      else
        flash[:success] = "Message not updated try again"
      end
      redirect_to :action => "edit", :id => @message.id
    end
	end

  def show
    @message = Message.find(params[:id])
    if @message.receiver == current_user
      @messages = current_user.received_messages
                  .order(created_at: :desc)
                  .paginate(:page => params[:page], :per_page => 30)
      @place = 'inbox'
    elsif @message.sent
      @messages = current_user.sent_messages
                  .where(sent: true)
                  .order(created_at: :desc)
                  .paginate(:page => params[:page], :per_page => 30)
      @place = 'sent'
    else
      @messages = current_user.sent_messages
                    .where(sent: false)
                    .order(created_at: :desc)
                    .paginate(:page => params[:page], :per_page => 30)
      @place = 'draft'
    end
  end

  def destroy
    @message = Message.find(params[:id])
    if @message.delete
  			flash[:success] = "Message deleted successfully"
      else
        flash[:success] = "Message could not be deleted try again"
      end
      redirect_to '/draft_messages'
  end
    
  def edit
    @message = Message.find(params[:id])
    @place = 'draft'
    @messages = current_user.sent_messages
                .where(sent: false)
                .order(created_at: :desc)
                .paginate(:page => params[:page], :per_page => 30)
    
		@cancel_path = message_path(@message.id)
    @users = User.all
    @groups = Group.all
  end
  
  def forward
    @message = Message.find(params[:message_id])
    text = "<br><blockquote>"+
                        "To: "+@message.receiver.name+"<br>"+
                        "From: "+@message.sender.name+"<br>"+
                        @message.content+"</blockquote>"
    @new_message = current_user.sent_messages.create(title: "Fwd: "+@message.title,
                        content: text,
                        sender: current_user,
                        sent: false)
    if @new_message.save
      flash[:success] = "New message"
      redirect_to :action => "edit", :id => @new_message.id
    else
      flash[:success] = "Message deleted successfully"
      redirect_to :back
    end
  end
  
  def reply
    @message = Message.find(params[:message_id])
    text = "<br><blockquote>To: "
    if !@message.receiver.nil? then text = text+@message.receiver.name else text = text+"No recipient" end
    text = text+"<br>From: "+@message.sender.name+"<br>"+
                        @message.content+"</blockquote>"
    @new_message = current_user.sent_messages.create(title: "Re: "+@message.title,
                        content: text,
                        sender: current_user,
                        receiver: @message.sender,
                        sent: false)
    if @new_message.save
      flash[:success] = "New message"
      redirect_to :action => "edit", :id => @new_message.id
    else
      flash[:success] = "Message deleted successfully"
      redirect_to :back
    end
  end

  private

    def message_params
      params.require(:message).permit(:title,:content)
    end
    def receivers_params
      params.require(:recipients).permit(:user_id)
    end
end
