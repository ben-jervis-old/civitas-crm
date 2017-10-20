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

    @title_options_list = ["Select a Service", "8:00am Service", "9:30am Service", "7:00pm Service"]
    @selected_option_title = "Select a Service"

    @selected_option_type = "Select a Type"
    @type_options_list = ["Select a Type", "Service", "Other"];
  end

	def edit
		@event = Event.find(params[:id])
		@cancel_path = event_path(@event)
		@event.event_time = @event.event_date.in_time_zone('Sydney')

    @title_options_list = ["Select a Service", "8:00am Service", "9:30am Service", "7:00pm Service"]
    @selected_option_title = @title_options_list.include? @event.title ? @event.title : "Select a Service"

    @selected_option_type = @event.event_type == "Service" ? "Service" : "Other"
    @type_options_list = ["Select a Type", "Service", "Other"];
	end

  def create
		@event = Event.new(event_params)

		if @event.save
			flash[:success] = 'Event created successfully';
			redirect_to @event
		else
      @cancel_path = events_path

      @title_options_list = ["Select a Service", "8:00am Service", "9:30am Service", "7:00pm Service"]
      @selected_option_title = "Select a Service"

      @selected_option_type = "Select a Type"
      @type_options_list = ["Select a Type", "Service", "Other"];
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
    @num_expected_users = User.where(main_service: @event.title).count if @event.event_type.downcase == 'service'
  end

	def attendance
		@event = Event.find(params[:id])
		@users = User.all.order(last_name: :asc).order(first_name: :asc)
		@main_users = User.where(main_service: @event.title) if @event.event_type.downcase == 'service'
		@main_was_empty = @main_users.nil?
		@main_users ||= @users
		@families = Group.where('lower(group_type) = ?', 'family').order(name: :asc)
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
      Time.zone = 'Sydney'
      unless (params[:event][:event_date]).blank? || (params[:event][:event_time]).blank?
        new_date = Time.zone.parse(params[:event][:event_time] + " " + params[:event][:event_date])
	      params[:event][:event_date] = new_date
      end
			params.require(:event).permit(:title, :event_date, :location, :repeat, :event_type)
		end
end
