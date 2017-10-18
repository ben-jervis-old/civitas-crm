class MessageMailer < ApplicationMailer
  default from: "messages@civitascrm.com"
  
  def new_message(message)
    @message = message
    @user = User.find(@message.receiver_id)
    mail to: @user.email, subject: 'New message on civitasCRM'
  end
end
