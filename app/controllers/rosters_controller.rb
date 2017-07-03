class RostersController < ApplicationController

  def index
    @rosters = Roster.all
  end

  def show
    @roster = Roster.find(params[:id])
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
