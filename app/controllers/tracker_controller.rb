class TrackerController < ApplicationController
  before_filter :authenticate_user!

  def index
    @articles = Article.all(:limit => 25, :order => "date desc")
    @json = ""
    Event.all.each do |event|
      @json << event.locations.to_gmaps4rails do |event, marker|
        marker.title event.name
        marker.infowindow render_to_string(:partial => "/shared/event_marker", :locals => {:object => event})
      end
    end
  end
end
