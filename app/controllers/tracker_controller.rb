class TrackerController < ApplicationController
  before_filter :authenticate_user!

  def index
    @articles = Article.all
  end

end
