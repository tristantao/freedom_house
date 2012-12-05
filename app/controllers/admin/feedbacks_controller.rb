class Admin::FeedbacksController < ApplicationController
  before_filter :admin_user?
  before_filter :authenticate_user!

  def index
  @feedbacks_active = Feedback.find_all_by_active(true)
  @feedbacks_resolved = Feedback.find_all_by_active(false)
  end

  def new
    feedback = params[:feedback]

    if feedback
      f = Feedback.create(:title => feedback[:title], :description => feedback[:description], :rating => feedback[:rating], :active => true)
      f.user = current_user
      f.last_updated_user = current_user.name
      if f.save
        flash[:notice] = "Thank you for submitting website feedback. An admin will respond as soon as possible."
        redirect_to admin_feedbacks_path
      else
        flash[:warning] = f.errors.full_messages.join(". ") + "."
      end
    end
  end

 def edit
   @feedback = Feedback.find_by_id(params[:id])
 end

 def update
   @feedback = Feedback.find_by_id(params[:id])
   @feedback.title = params[:feedback][:title]
   @feedback.description = params[:feedback][:description]
   @feedback.rating = params[:feedback][:rating]
   @feedback.active = params[:feedback][:active]

   if @feedback.save
     flash[:notice] = "Successfully updated feedback form!"
   else
     flash[:warning] = @feedback.errors.full_messages.join(". ")
   end
   redirect_to admin_feedbacks_path
 end



 def resolve
   @feedback = Feedback.find_by_id(params[:id])
   @feedback.active = false
   @feedback.save
   redirect_to admin_feedbacks_path
 end


 def delete
   @feedback = Feedback.find_by_id(params[:id])
   @feedback.delete
   flash[:notice] = "Feedback has been deleted."
   redirect_to admin_feedbacks_path
 end

 def view
  @feedback = Feedback.find_by_id(params[:id])
 end





  protected
  def admin_user?
    redirect_to root_path() unless user_signed_in? && current_user.admin?
  end
end
