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
      # Handle a successful update.
    else
      render 'edit'
    end
	end
end
