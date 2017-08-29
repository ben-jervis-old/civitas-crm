class ContactsController < ApplicationController
  def index
    @contacts = Contact.all
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
  end
  
  private

    def message_params
      params.require(:contact).permit(:title,:content)
    end
end
