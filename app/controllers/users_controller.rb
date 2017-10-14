class UsersController < ApplicationController

  before_action :get_user,          	only: [:edit, :show, :update, :update_password, :edit_privacy, :update_privacy]
	skip_before_action :require_login, 	only: [:signup, :signup_create]
	before_action :check_staff,					only: [:new, :destroy, :create]
  before_action :check_permission,    only: [:edit, :update]

	def index
		if current_user.is_staff?
			@users = User.all.order(:last_name)
		else
			@users = User.all.order(:last_name).select{ |usr| usr.privacy_setting.presence || usr.id == current_user.id }
		end
	end

	def new
		@user = User.new
	end

	def signup
		@user = User.new
	end

	def edit
	end

	def show
		if !(@user.privacy_setting.presence || current_user.is_staff? || current_user.id == @user.id)
			flash[:warning] = 'Member not found'
			redirect_to users_path
		else
			@pronoun = @user == current_user ? "You're" : "This user is"
			@address_link = "https://www.google.com.au/maps/place/#{CGI::escape(@user.address)}" unless @user.address.nil?
		end
	end

	def update
    if @user.update_attributes(user_params)
			flash[:success] = "Details updated successfully"
      redirect_to @user
    else
      render 'edit'
    end
	end

	def update_password
		if @user.update_attributes(password_params_only)
			flash[:success] = "Your password has been updated"
			#TODO email password update notification
			redirect_to @user
		else
			render 'update_password'
		end
	end

	def update_photo
		@user = User.find(params[:user_id])

		@user.image = params[:user][:image]
		if @user.save
			flash[:success] = 'Photo successfully updated'
		else
			flash[:danger] = 'There was an error uploading your photo'
		end

		redirect_to @user
	end

	def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
	end

	# For admins creating users inside the app
	def create
		@user = User.new(user_params)
		temporary_password = User.new_token
		@user.password = @user.password_confirmation = temporary_password
		@user.level ||= 'member'

		if @user.save
			@user.create_reset_digest
			@user.send_account_setup_email
			@user.create_privacy_setting
			flash[:success] = "User created successfully"
			redirect_to users_path
		else
			render 'new'
		end
	end

	def signup_create
		@user = User.new(user_signup_params)
		@user.level = 'visitor'

		if @user.save
			@user.send_activation_email
			@user.create_privacy_setting
			log_in @user
			flash[:success] = 'Welcome to civitasCRM!'

			notification = Notification.create(title: 'New Member', content: "#{@user.name} has created an account", resolve_link: user_path(@user))
			notification.users << User.where(level: 'staff')

			redirect_to root_path
		else
			render 'signup'
		end
	end

	def edit_privacy
		user_has_setting = !!@user.privacy_setting
		@user.create_privacy_setting unless user_has_setting
	end

	def update_privacy
		if @user.privacy_setting.update_attributes(privacy_params)
			flash[:success] = 'Privacy settings updated'
			redirect_to @user
		else
			render 'edit_privacy'
		end
	end

	private

	def privacy_params
		params.require(:privacy_setting).permit(:presence, :mobile_number, :work_number, :home_number, :address, :email, :dob, :user_created_at)
	end

		def get_user
			@user = User.find(params[:id] || params[:user_id])
		end

    def user_params
			[:mobile_number, :work_number, :home_number].each do |param|
				params[:user][param] = params[:user][param].split.join('').to_i
			end
			params[:user][:level] ||= 'visitor'
      params.require(:user).permit(	:first_name,
																		:last_name,
																		:email,
																		:address,
																		:mobile_number,
																		:work_number,
																		:home_number,
																		:dob,
																		:main_service,
																		:occupation,
																		:password,
																		:password_confirmation,
																		:level,
																		:image )
    end

		def user_signup_params
			params.require(:user).permit(	:first_name,
																		:last_name,
																		:email,
																		:password,
																		:password_confirmation )
		end

		def check_staff
			if !current_user.is_staff?
				flash[:warning] = "You don't have access to that action"
				redirect_to users_path
			end
		end

    def check_permission
      unless current_user == @user || current_user.is_staff?
        flash[:warning] = "You don't have access to that action"
        redirect_to users_path
      end
    end
end
