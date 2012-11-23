class Admin::SourcesController < ApplicationController

  def index
    @sources = Source.find(:all, :order => "created_at DESC")
  end

 def new
    sourcesinput = params[:source]
    if sourcesinput
      s = Source.create(:name => sourcesinput[:name], :home_page => sourcesinput["home_page"], :quality_rating => sourcesinput[:quality_rating], :url => sourcesinput["url"])
      if s.save
        flash[:notice] = "Source #{sourcesinput[:name]} has been created!"
        redirect_to admin_sources_path
      else
        flash[:warning] = s.errors.full_messages.join(". ")
      end
    end
  end

  def edit
      @source = Source.find(params[:id])
  end

  def update
    @source = Source.find(params[:id])
    @source.name = params[:source][:name]
    @source.home_page = params[:source][:home_page]
    @source.quality_rating = params[:source][:quality_rating]
    if @source.save
      flash[:notice] = "Successfully updated source!"
    else
      flash[:warning] = @source.errors.full_messages.join(". ")
    end
    redirect_to admin_sources_action_path(:edit, @source.id)
  end
  
  def delete
    @source = Source.find(params[:id])
    name = @source.name
    @source.delete
    flash[:notice] = "Source #{name} has been deleted."
    redirect_to admin_sources_path
  end
end
