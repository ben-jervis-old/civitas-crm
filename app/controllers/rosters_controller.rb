class RostersController < ApplicationController

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
  end

	def edit
		@roster = Roster.find(params[:id])
	end

  def create
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
end
