class TasksController < ApplicationController
	before_action :set_task_and_check_roster, only: [:show, :edit, :update, :destroy]
	before_action :check_staff, except: [:show, :accept]

	def new
		@roster = Roster.find(params[:roster_id])
		@task = @roster.tasks.build
		@users = User.all.sort_by{ |usr| [usr.last_name, usr.first_name]}
		@user_options_list = @users.map{ |usr| [usr.name, usr.id] }.unshift(['Choose a user...', 0])
		@cancel_path = roster_path(@roster)
	end

	def create
		@roster = Roster.find(params[:roster_id])
		@task = @roster.tasks.build(task_params)

		if @task.save
			flash[:success] = 'Task saved successfully'
			redirect_to @roster
		else
			render :new
		end
	end

	def show
		@all_users =  User.all
											.sort_by{ |usr| [usr.last_name, usr.first_name] }
											.reject{ |usr| @task.users.include? usr }

		@not_accepted = @task.users.include?(current_user) &&
										!@task.assignments
													.select{ |ass| ass.user_id == current_user.id }
													.first
													.accepted
	end

	def edit
		@cancel_path = roster_task_path(@task.roster, @task)
	end

	def update
		if @task.update_attributes(task_params)
			flash[:success] = 'Task updated successfully'
			redirect_to [@task.roster, @task]
		else
			render :edit
		end
	end

	def assign
		@task = Task.find(params[:task_id])
		user = User.find(params[:user_id])
		@task.users << user
		flash[:success] = "#{user.name} assigned to this task"
		user.notifications.create(title: "New Task",
															content:"You have been assigned to the \"#{@task.title}\" task in the \"#{@task.roster.title}\" roster.",
															resolve_link: roster_task_path(@task.roster.id, @task.id))
		redirect_to roster_task_path(@task.roster, @task)
	end

	def unassign
		@task = Task.find(params[:task_id])
		user = User.find(params[:user_id])
		@task.users.delete user
		flash[:success] = "#{user.name} removed from this task"
		user.notifications.create(title: 'Removed from Task',
															content: "You no longer need to complete the \"#{@task.title}\" task in the \"#{@task.roster.title}\" roster.",
															resolve_link: roster_task_path(@task.roster.id, @task.id))
		redirect_to roster_task_path(@task.roster.id, @task.id)
	end

	def accept
		@task = Task.find(params[:task_id])
		user = User.find(params[:user_id])
		if user == current_user
			@task.assignments
						.select{ |ass| ass.user_id == user.id }
						.first
						.update_attribute(:accepted, true)
			flash[:success] = "You have accepted this task"
			redirect_to roster_task_path(@task.roster_id, @task.id)
		else
			flash[:danger] = "You are not authorised to do this"
			redirect_to roster_task_path(@task.roster_id, @task.id)
		end
	end

	def destroy
		roster = @task.roster
		@task.destroy
		flash[:success] = 'Task successfully deleted'
		redirect_to roster
	end

	private

		def check_staff
			if !current_user.is_staff?
				flash[:warning] = "You don't have access to that action"
				redirect_to rosters_path
			end
		end

		def task_params
			params.require(:task).permit(:title, :due, :location, :notes)
		end

		def set_task_and_check_roster
			@task = Task.find(params[:id])
			if @task.roster != Roster.find_by_id(params[:roster_id])
				flash[:warning] = 'Invalid URL'
				redirect_to rosters_path
			end
		end
end
