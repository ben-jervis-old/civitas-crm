class MessagesController < ApplicationController
  def index
    @messages = Contact.all
  end

  def new
    @contact = Contact.new
  end
  
  def create
		@contact = Contact.new(message_params)

		if @contact.save
			flash[:success] = "Message created successfully"
			redirect_to contacts_path
		else
			render 'new'
		end
	end

  def show
    @contact = Contact.find(params[:id])
  end

  def delete
  end

  def edit
    @contact = Contact.find(params[:id])
		@cancel_path = contact_path(@contact.id)
  end
  
  def recipients
    @contact = Contact.find(params[:contact_id])
    @users = User.all
  end
  
  def assign
		@contact = Contact.find(params[:contact_id])
		user = User.find(params[:user_id])
		@contact.Recipients << user
		redirect_to contact_path(@contact)
	end

	def unassign
		@contact = Contact.find(params[:group_id])
		user = User.find(params[:user_id])
		@contact.Recipients.delete user
		redirect_to contact_path(@contact)
	end
  
  private

    def message_params
      params.require(:contact).permit(:title,:content)
    end
end
