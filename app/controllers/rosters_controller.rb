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

  def create
  end

  def update
  end

  def destroy
  end
end
