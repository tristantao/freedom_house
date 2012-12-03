class Admin::ResponsesController < ApplicationController
  before_filter :admin_user?  
  before_filter :authenticate_user!
  
  def new
    response = params[:response]
    @feedback = Feedback.find(params[:feedback_id])
    if response
      r = Response.create(:commenter => current_user.name, :body => response[:body], :created_at => Time.now, :updated_at => Time.now)
      r.feedback = @feedback
      @feedback.last_updated_user = current_user.name
      @feedback.updated_at = Time.now
      @feedback.save
      if r.save
        flash[:notice] = "Comment submitted."
        redirect_to admin_feedbacks_action_path(:view, params[:feedback_id])
      else
        flash[:warning] = r.errors.full_messages.join(". ") + "."
      end
    end
  end

  protected
  def admin_user?
    redirect_to root_path() unless user_signed_in? && current_user.admin
  end



 
end
