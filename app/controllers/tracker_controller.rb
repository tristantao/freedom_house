class TrackerController < ApplicationController
  before_filter :authenticate_user!

  def index
    @articles = Article.all
    @json = Event.all.to_gmaps4rails
  end

end
