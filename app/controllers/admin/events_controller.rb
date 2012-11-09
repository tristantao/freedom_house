class Admin::EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def new
    event = params[:event]
    if event
      e = Event.create(:name => event[:name], :description => event[:description], :date => event[:date], :longitude => event[:longitude], :latitude => event[:latitude], :country => event[:Country], :province => event[:province], :city => event[:city])
      if e.save
        flash[:notice] = "Article #{event[:name]} has been created!"
        redirect_to admin_events_path
      else
        flash[:warning] = "Error in creating event. Please try again."
      end
    end
  end
  def edit
    @event = Event.find(params[:id])
  end
  def update
    @event = Source.find(params[:id])
    @event.name = params[:event][:name]
    @event.date = params[:event][:date]
    @event.description = params[:event][:description]
    @event.longitude = params[:event][:longitude]
    @event.latitude = params[:event][:latitude]
    @event.country = params[:event][:Country]
    @event.province = params[:event][:province]
    @event.city = params[:event][:city]

    if @event.save
      flash[:notice] = "Successfully updated event!"
    else
      flash[:warning] = "Error in editing event. Please try again."
    end
    redirect_to admin_events_action_path(:edit, @event.id)
  end
end
