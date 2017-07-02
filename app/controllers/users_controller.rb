class UsersController < ApplicationController
	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def edit
    @user = User.find(params[:id])
	end

	def show
    @user = User.find(params[:id])

		phone_num = @user.phone_number.to_s.rjust(10, '0')
		@formatted_phone = "#{phone_num[0..3]} #{phone_num[4..6]} #{phone_num[7..9]}"

		@address_link = "https://www.google.com.au/maps/place/#{CGI::escape(@user.address)}"
	end

	def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      render 'show'
    else
      render 'edit'
    end
	end

	def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
	end

	def create
		@user = User.new(user_params)
		if @user.save
			log_in @user
			flash[:success] = "Welcome to civitasCRM"
			redirect_to @user
		else
			render 'new'
		end
	end

	private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :address,
                                   :phone_number, :dob)
    end
end
