class EventsController < ApplicationController
  def index
		@future_events = Event.where('event_date >= ?', Time.zone.now.to_date + 7).order(event_date: :asc)
		@this_weeks_events = Event.where('event_date >= ?', Time.zone.now.to_date).where('event_date < ?', Time.zone.now.to_date + 7).order(event_date: :asc)
  end

	def past
		@past_events = Event.where('event_date < ?', Time.zone.now.to_date)
	end

  def new
		@event = Event.new
		@cancel_path = events_path
  end

	def edit
		@event = Event.find(params[:id])
		@cancel_path = event_path(@event)
		@event.event_time = @event.event_date.localtime
	end

  def create
		@event = Event.new(event_params)

		if @event.save
			flash[:success] = 'Event created successfully';
			redirect_to @event
		else
			render 'new'
		end
  end

  def update
		@event = Event.find(params[:id])

		if @event.update_attributes(event_params)
			flash[:success] = 'Event updated successfully'
			redirect_to @event
		else
			render 'edit'
		end
  end

  def show
		@event = Event.find(params[:id])
		@present_users = @event.users.sort_by{ |user| [user.last_name, user.first_name] }
  end

	def attendance
		@event = Event.find(params[:id])
		@main_users = User.where(main_service: @event.title) if @event.event_type.downcase == 'service'
		@families = Group.where('lower(group_type) = ?', 'family').order(name: :asc)
		@users = User.all.order(last_name: :asc).order(first_name: :asc)
	end

	def next
		@event = Event.find(params[:id])

		new_event = @event.next_occurrence

		if new_event.save
			flash[:success] = 'New event created successfully'
			redirect_to new_event
		else
			flash[:danger] = 'There was an error creating the new event'
			render 'show'
		end
	end

	def mark
		event = Event.find(params[:event_id])
		user = User.find(params[:user_id])
		event.users << user
		render json: {}, status: :ok
	end

	def unmark
		event = Event.find(params[:event_id])
		user = User.find(params[:user_id])
		event.users.delete(user.id)
		render json: {}, status: :ok
	end

	private

		def event_params
			new_date = Time.parse(params[:event][:event_time] + " " + params[:event][:event_date])
			params[:event][:event_date] = new_date
			params.require(:event).permit(:title, :event_date, :location, :repeat, :event_type)
		end
end
