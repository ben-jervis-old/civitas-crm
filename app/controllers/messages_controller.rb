class MessagesController < ApplicationController
  
  def index
    @messages = current_user.received_messages
                    .where(receiver_delete: false)
                    .order(created_at: :desc)
                    .paginate(:page => params[:page], :per_page => 30)
    @place = 'inbox'
  end
  
  def sent_messages
    @messages = current_user.sent_messages
                    .where(sender_delete: false)
                    .order(created_at: :desc)
                    .paginate(:page => params[:page], :per_page => 30)
    @place = 'sent'
  end

  def new
    @message = Message.new
    @users = User.all
    @groups = Group.all
  end
  
  def create
    message = current_user.sent_messages.create(message_params)
	  message.sent = true
    params[:recipients][:user_id].each  do |id|
      if id[0] == "U"
        id = id[1..-1]
        @recipient = User.find(id)
        @recipient.received_messages.create(title: message.title,
                      content: message.content,
                      sender: message.sender,
                      receiver: @recipient,
                      sent: true)
        MessageMailer.new_message(@recipient.received_messages.last).deliver_now
      elsif id[0] == "G"
        id = id[1..-1]
        @group = Group.find(id)
        @group.memberships.each do |mem|
          @recipient = User.find(mem.user_id)
          @recipient.received_messages.create(title: message.title,
                      content: message.content,
                      sender: message.sender,
                      receiver: @recipient,
                      sent: true)
        end
      end
    end
    message.delete
    redirect_to action: 'sent_messages'
    
	end
	
	def update
    message = Message.find(params[:id])
    
	  message.sent = true
    params[:recipients][:user_id].each  do |id|
      if id[0] == "U"
        id = id[1..-1]
        recipient = User.find(id)
        recipient.received_messages.create(title: message.title,
                      content: message.content,
                      sender: message.sender,
                      receiver: recipient,
                      sent: true)
        MessageMailer.new_message(recipient.received_messages.last).deliver_now
      elsif id[0] == "G"
        id = id[1..-1]
        group = Group.find(id)
        group.memberships.each do |mem|
          recipient = User.find(mem.user_id)
          recipient.received_messages.create(title: message.title,
                      content: message.content,
                      sender: message.sender,
                      receiver: recipient,
                      sent: true)
        end
      end
    end
    message.delete
    redirect_to action: 'sent_messages'
	end

  def show
    @message = Message.find(params[:id])
    if @message.receiver == current_user
      @messages = current_user.received_messages
                  .order(created_at: :desc)
                  .paginate(:page => params[:page], :per_page => 30)
      @message.read = true
      if !@message.save
        flash[:success] = "read not set to true"
      end
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
    if current_user == @message.receiver
      @message.receiver_delete = true
    end
    if current_user == @message.sender
      @message.sender_delete = true
    end
    if @message.sender_delete and @message.receiver_delete 
      if @message.delete
  			flash[:success] = "Message deleted successfully"
      else
        flash[:success] = "Message could not be deleted try again"
      end
    else
      if @message.save
  			flash[:success] = "Message deleted successfully"
      else
        flash[:success] = "Message could not be deleted try again"
      end
    end
    if current_user == @message.receiver
      redirect_to messages_path
    else
      redirect_to sent_messages_path
    end
    
  end
    
  def edit
    @message = Message.find(params[:id])
		@cancel_path = message_path(@message.id)
    @users = User.all
    @groups = Group.all
  end
  
  def forward
    @message = Message.find(params[:message_id])
    text = "<br><br><blockquote>To: "
    if !@message.receiver.nil? then text = text+@message.receiver.name else text = text+"No recipient" end
    text = text+"<br>From: "+@message.sender.name+"<br>"+
                        @message.content+"</blockquote>"
    @new_message = current_user.sent_messages.create(title: "Fwd: "+@message.title,
                        content: text,
                        sender: current_user,
                        sent: false)
    if @new_message.save
      redirect_to :action => "edit", :id => @new_message.id
    else
      flash[:error] = "Error: Message not created"
      redirect_to :back
    end
  end
  
  def reply
    @message = Message.find(params[:message_id])
    text = "<br><br><blockquote>To: "
    if !@message.receiver.nil? then text = text+@message.receiver.name else text = text+"No recipient" end
    text = text+"<br>From: "+@message.sender.name+"<br>"+
                        @message.content+"</blockquote>"
    @new_message = current_user.sent_messages.create(title: "Re: "+@message.title,
                        content: text,
                        sender: current_user,
                        receiver: @message.sender,
                        sent: false)
    if @new_message.save
      redirect_to :action => "edit", :id => @new_message.id
    else
      flash[:error] = "Error: Message not created"
      redirect_to :back
    end
  end
  
  def unread
    @message = Message.find(params[:message_id])
    @message.read = false
    if !@message.save
      flash[:success] = "read not set to true"
    end
    redirect_to messages_path
  end
  
  def read
    @message = Message.find(params[:message_id])
    @message.read = true
    if !@message.save
      flash[:success] = "read not set to true"
    end
    redirect_to messages_path
  end

  private

    def message_params
      params.require(:message).permit(:title,:content)
    end
    def receivers_params
      params.require(:recipients).permit(:user_id)
    end
end
