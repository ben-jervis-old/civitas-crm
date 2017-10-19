class MessagesController < ApplicationController

  def index
    @inbox_messages = current_user.received_messages
                                  .where(receiver_delete: false)
                                  .order(created_at: :desc)
                                  .paginate(:page => params[:page], per_page: 15)
    @sent_messages = current_user.sent_messages
                                 .where(sender_delete: false)
                                 .order(created_at: :desc)
                                 .paginate(:page => params[:page], per_page: 15)
    @sent_active = false
  end

  def new
    @message = Message.new
    @users = User.where.not(id: current_user.id)
    @groups = Group.all
  end

  def create
    user_list = (params[:recipients]).select{ |id| id.include? 'U'}
                                     .map{ |id| id.tr('U', '').to_i }
    group_list = (params[:recipients]).select{ |id| id.include? 'G'}
                                      .map{ |id| id.tr('G', '').to_i }
                                      .map{ |id| Group.find(id).users.collect(&:id) }

    send_list = [user_list, group_list].flatten.uniq

	  send_list.each  do |id|
      new_msg = Message.new(title:        params[:message][:title],
                            content:      params[:message][:content],
                            sender_id:    current_user.id,
                            receiver_id:  id,
                            sent:         true,
                            sent_at:      Time.zone.now )
      if new_msg.save
        MessageMailer.new_message(new_msg).deliver_now
      end
    end
    redirect_to messages_path
  end

  def show
    @message = Message.find(params[:id])
    @message.update_attribute(:read, true) if @message.receiver_id == current_user.id

    @inbox_messages = current_user.received_messages
                                  .where(receiver_delete: false)
                                  .order(created_at: :desc)
                                  .paginate(:page => params[:page], per_page: 15)
    @sent_messages = current_user.sent_messages
                                 .where(sender_delete: false)
                                 .order(created_at: :desc)
                                 .paginate(:page => params[:page], per_page: 15)

    @sent_active = @message.sender_id == current_user.id
    @from_to = @sent_active ? 'To' : 'From'
    @display_user = @sent_active ? @message.receiver : @message.sender
  end

  def destroy
    @message = Message.find(params[:id])

    @message.receiver_delete ||= current_user.id == @message.receiver_id

    @message.sender_delete ||= current_user.id == @message.sender_id

    if @message.sender_delete && @message.receiver_delete
      success = !!@message.delete
    else
      success = !!@message.save
    end

    if success
      flash[:success] = "Message deleted successfully"
    else
      flash[:success] = "Message could not be deleted try again"
    end

    redirect_to messages_path
  end

  def forward
    @original_message = Message.find(params[:message_id])
    new_content = """
    <br>
    <br>
    <blockquote>
      <p>To: #{@original_message.receiver.name}</p>
      <p>From: #{@original_message.sender.name}</p>
      <p>Date: #{@original_message.sent_at}</p>
      <div>#{@original_message.content}</div>
    </blockquote>
    """

    @message = Message.new( title: "Fw: #{@original_message.title}",
                            content: new_content,
                            sender_id: current_user.id,
                            sent: false)
    @users = User.where.not(id: current_user.id)
    @groups = Group.all
    render 'new'
  end

  def reply
    @original_message = Message.find(params[:message_id])
    new_content = """
    <br>
    <br>
    <blockquote>
      <p>To: #{@original_message.receiver.name}</p>
      <p>From: #{@original_message.sender.name}</p>
      <p>Date: #{@original_message.sent_at}</p>
      <div>#{@original_message.content}</div>
    </blockquote>
    """

    @message = Message.new( title: "Re: #{@original_message.title}",
                            content: new_content,
                            sender_id: current_user.id,
                            receiver_id: @original_message.sender_id,
                            sent: false)
    if @message.valid?
      @users = User.where.not(id: current_user.id)
      @groups = Group.all
      render 'new'
    else
      flash[:error] = "Reply was not able to be created"
      redirect_to :back
    end
  end

  def unread
    @message = Message.find(params[:message_id])
    @message.read = false
    if !@message.save
      flash[:warning] = "Unable to update status"
    end
    redirect_to messages_path
  end

  def read
    @message = Message.find(params[:message_id])
    @message.read = true
    if !@message.save
      flash[:warning] = "Unable to update status"
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
