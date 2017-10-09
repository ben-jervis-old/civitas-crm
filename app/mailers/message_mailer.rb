class MessageMailer < ApplicationMailer
  default from: "messages@civitascrm.com"
  
  def new_message(message)
    @message = message
    mail to: @Message.recipient.email, subject: 'New message on civitasCRM'
  end
end
