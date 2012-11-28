class HomeController < ApplicationController
  layout "carousel"

  def index
    if user_signed_in?
      redirect_to home_path
    end
  end
end
