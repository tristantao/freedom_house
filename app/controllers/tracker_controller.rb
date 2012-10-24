class TrackerController < ApplicationController
  before_filter :authenticate_user!

  def home
    @articles = Article.all
  end

end
