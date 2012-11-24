class Admin::EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def new
    event = params[:event]
    if event
      e = Event.create(:name => event[:name], :description => event[:description], :date => event[:date], :longitude => event[:longitude], :latitude => event[:latitude], :country => event[:country], :province => event[:province], :city => event[:city])
      if e.save
        flash[:notice] = "Event #{event[:name]} has been created!"
        redirect_to admin_events_path
      else
        flash[:warning] = s.errors.full_messages.join(". ")
      end
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.name = params[:event][:name]
    @event.date = params[:event]['date(3i)'] + "/" + params[:event]['date(2i)'] + "/" + params[:event]['date(1i)']
    @event.description = params[:event][:description]
    @event.longitude = params[:event][:longitude]
    @event.latitude = params[:event][:latitude]
    @event.country = params[:event][:country]
    @event.province = params[:event][:province]
    @event.city = params[:event][:city]

    if @event.save
      flash[:notice] = "Successfully updated event!"
    else
      flash[:warning] = s.errors.full_messages.join(". ")
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
    @json = Event.all.to_gmaps4rails do |event, marker|
      marker.title event.name
      marker.infowindow render_to_string(:partial => "/shared/event_marker", :locals => {:object => event})
    end
  end
end
