class RostersController < ApplicationController

	before_action :check_staff, except: [:show, :index]

  def index
    @rosters = Roster.all
  end

  def show
    @roster = Roster.find(params[:id])
		@formatted_start_date = @roster.start_date.strftime("%d %B %Y")
		@formatted_end_date = (@roster.start_date + @roster.duration).strftime("%d %B %Y")
  end

  def new
    @roster = Roster.new
		@cancel_path = rosters_path
  end

	def edit
		@roster = Roster.find(params[:id])
		@cancel_path = roster_path(@roster.id)
	end

  def create
		@roster = Roster.new(roster_params)

		if @roster.save
			flash[:success] = 'Roster created successfully'
			redirect_to roster_path(@roster.id)
		else
			render 'new'
		end
  end

  def update
		@roster = Roster.find(params[:id])

    if @roster.update_attributes(roster_params)
			flash[:success] = "Details updated successfully"
      redirect_to @roster
    else
      render 'edit'
    end
  end

  def destroy
  end

	private

		def roster_params
			params.require(:roster).permit(:title, :start_date, :duration, :description)
		end

		def check_staff
			if !current_user.is_staff?
				flash[:warning] = "You don't have access to that action"
				redirect_to params[:id] ? Roster.find(params[:id]) : rosters_path
			end
		end
end
