class Admin::EventsController < ApplicationController
  before_filter :admin_user?
  before_filter :authenticate_user!
  def index
    @events = Event.all
    @event_city = {}
    @event_country = {}
    @event_longitude = {}
    @event_latitude = {}

    @events.each do |e|
      loc = e.locations
      if not loc.size == 0
        @event_city[e.id] = loc[0].name
        @event_country[e.id] = loc[0].country
        @event_latitude[e.id] = loc[0].latitude
        @event_longitude[e.id] = loc[0].longitude
      else
        @event_city[e.id] = ""
        @event_country[e.id] = ""
        @event_latitude[e.id] = 0.00
        @event_longitude[e.id] = 0.00
      end
    end

  end

  def new
    event = params[:event]
    found_loc = true
    if event
      e = Event.create(:name => event[:name], :description => event[:description], :date => DateTime.try(:strptime, event[:date], "%m/%d/%Y"))
      loc = Location.find_by_name(event[:city])
      if loc.nil?
        loc = Location.create(:name => event[:city], :latitude => event[:latitude].to_f, :longitude => event[:longitude].to_f, :country => event[:country])
        found_loc = false
      end
      e.locations << loc
      if e.save
        message = "Event #{event[:name]} has been created!"
        if found_loc
          message = message + " We also found a city in the existing database with the same name, with Lat: #{loc.latitude} and Long: #{loc.longitude}. Using the existing location instead. Rename the location if you want to add a new Location"
        end
        flash[:notice] = message
        redirect_to admin_events_path
      else
        flash[:warning] = e.errors.full_messages.join(". ") + "."
      end
    end
  end

  def edit
    @event = Event.find(params[:id])
    @event.date = @event.date.strftime("%m/%d/%Y")
  end

  def update
    @event = Event.find(params[:id])
    @event.name = params[:event][:name]
    @event.date =  DateTime.try(:strptime, params[:event][:date], "%m/%d/%Y")
    @event.description = params[:event][:description]
    @loc = Location.first(:conditions => {:longitude => params[:event][:longitude], :latitude => params[:event][:latitude]})

    if @loc.nil?
      @loc = Location.create(:name => params[:event][:city], :latitude => params[:event][:latitude], :longitude => params[:event][:longitude], :country => params[:event][:country])
      @event.locations << @loc
    else
      @loc.name = params[:event][:city]
      @loc.country = params[:event][:country]
      @loc.latitude = params[:event][:latitude]
      @loc.longitude = params[:event][:longitude]
      @loc.save
    end

    if @event.save
      flash[:notice] = "Successfully updated event!"
    else
      flash[:warning] = @event.errors.full_messages.join(". ") + "."
    end
    redirect_to admin_events_action_path(:edit, @event.id)
  end

  def delete
    @event = Event.find(params[:id])
    name = @event.name
    @event.delete
    flash[:notice] = "Event #{name} has been deleted."
    redirect_to admin_events_path
  end

  def map
    @json = ""
    locations = []
    Event.all.each do |event|
      event.locations.each do |loc|
        locations << loc
      end
    end
    
    @json << locations.to_gmaps4rails do |event, marker|
      marker.title event.name
      marker.infowindow render_to_string(:partial => "/shared/event_marker", :locals => {:object => event})
    end
  end
  
  protected
  def admin_user?
    redirect_to root_path() unless user_signed_in? && current_user.admin?
  end
end
