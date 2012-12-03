class FeedbacksController < ApplicationController
  before_filter :authenticate_user!
 
  
  def index
  @feedbacks = current_user.feedbacks
  @feedbacks_active = []
  @feedbacks_resolved = []
  @feedbacks.each do |feedback|
    if feedback.active
      @feedbacks_active << feedback
    else 
      @feedbacks_resolved << feedback
    end
  end
  end

  def new
    feedback = params[:feedback]

    if feedback
      f = Feedback.create(:title => feedback[:title], :description => feedback[:description], :rating => feedback[:rating], :active => true)
      f.user = current_user
      f.last_updated_user = current_user.name
      if f.save
        flash[:notice] = "Thank you for submitting website feedback. An admin will respond as soon as possible."
        redirect_to feedbacks_index_path
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
   @feedback.last_updated_user = current_user.name
   if @feedback.save
     flash[:notice] = "Successfully updated feedback form!"
   else
     flash[:warning] = @feedback.errors.full_messages.join(". ")
   end
   redirect_to feedbacks_index_path
 end
 

 def delete
   @feedback = Feedback.find_by_id(params[:id])
 end

 def view 
  @feedback = Feedback.find_by_id(params[:id])
 end



 
end
