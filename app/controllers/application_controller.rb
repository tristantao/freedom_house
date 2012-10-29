class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    if (current_user.try(:admin?))
      admin_dashboard_path
    else
      home_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

end
