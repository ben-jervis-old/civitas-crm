class MessagesController < ApplicationController
  def index
    @messages = current_user.received
    @place = 'inbox'
  end
  
  def sent_messages
    @messages = current_user.messages
                    .where(sent: true)
                    .order(created_at: :desc)
    
    @place = 'sent'
  end
  
  def draft_messages
    @messages = current_user.messages
                    .where(sent: false)
                    .order(created_at: :desc)
    
    @place = 'draft'
  end

  def new
    @message = Message.new
    @messages = current_user.messages
                    .where(sent: false)
                    .order(created_at: :desc)
    
    @place = 'draft'
    @users = User.all
  end
  
  def update
    @message = Message.find(params[:id])

    if @message.update_attributes(message_params)
			flash[:success] = "Message updated successfully"
      redirect_to @message
    else
      flash[:success] = "Message not updated try again"
      render @message
    end
  end
  
  def create
		@message = current_user.messages.create(message_params)

		if @message.save
			flash[:success] = "Message created successfully"
			redirect_to messages_path
		else
			render 'new'
		end
	end

  def show
    @message = Message.find(params[:id])
    if @message.sent
      @messages = current_user.messages
                  .where(sent: false)
                  .order(created_at: :desc)
      
      @place = 'sent'
    else
      @messages = current_user.messages
                    .where(sent: true)
                    .order(created_at: :desc)
      
      @place = 'draft'
    end
  end

  def delete
  end

  def edit
    @message = Message.find(params[:id])
		@cancel_path = message_path(@message.id)
		@messages = current_user.messages
                  .where(sent: false)
                  .order(created_at: :desc)
    @place = 'draft'
    @users = User.all
  end
  
  def recipients
    @message = Message.find(params[:message_id])
    @users = User.all
  end
  
  def assign
		@message = Message.find(params[:message_id])
		user = User.find(params[:user_id])
		@message.Recipients << user
		redirect_to message_path(@message)
	end

	def unassign
		@message = Message.find(params[:group_id])
		user = User.find(params[:user_id])
		@message.Recipients.delete user
		redirect_to message_path(@message)
	end
  
  private

    def message_params
      params.require(:message).permit(:title,:content)
    end
end
