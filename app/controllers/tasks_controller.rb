class TasksController < ApplicationController
	before_action :set_task_and_check_roster, only: [:show, :edit, :update, :destroy]

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

	def destroy
		roster = @task.roster
		@task.destroy
		flash[:success] = 'Task successfully deleted'
		redirect_to roster
	end

	private

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
