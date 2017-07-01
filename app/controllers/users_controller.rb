class UsersController < ApplicationController
	def new
		@user = User.new
	end
	
	def edit
    @user = User.find(params[:id])
	end
	
	def show
    @user = User.find(params[:id])
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
	
	private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :address,
                                   :phone_number, :dob)
    end
end
