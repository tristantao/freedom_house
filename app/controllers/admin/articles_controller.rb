class Admin::ArticlesController < ApplicationController

  before_filter :admin_user?
  before_filter :authenticate_user!

  def index
    @articles = Article.all
    @article_city = {}
    @article_country = {}
    @articles.each do |a|
      loc = a.locations
      if not loc.size == 0
        @article_city[a.id] = loc[0].name
        @article_country[a.id] = loc[0].country
      else
        @article_city[a.id] = ""
        @article_country[a.id] = ""
      end
    end
  end


  def new
    article = params[:article]
    if article
      s = Article.create(:title => article[:title], :date => article[:date], :author=> article[:author], :link => article[:link], :text => article[:text])
       loc = Location.find_by_name(article[:city])
      if loc.nil?
        loc = Location.create(:name => article[:city], :latitude => 0.0, :longitude => 0.0, :country => article[:country])
      end
      s.locations << loc
      if s.save
  flash[:notice] = "Article #{article[:title]} has been created!"
  redirect_to admin_articles_path
      else
  flash[:warning] = "Error in creating article. Please try again."
      end
    end
  end


  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.title = params[:article][:title]
    @article.date = params[:article][:date]
    @article.author = params[:article][:author]
    @article.location = params[:article][:location]
    @article.link = params[:article][:link]
    @article.text = params[:article][:text]
    if @article.save
      flash[:notice] = "Successfully updated article!"
    else
      flash[:warning] = @article.errors.full_messages.join(". ")
    end
    redirect_to admin_article_action_path(:edit, @artcle.id)
  end

  def edit
  end

  def delete
    @article = Article.find_by_id(params[:id])
    title = @article.title
    @article.destroy
    flash[:notice] = "Article #{title} has been deleted."
    redirect_to admin_articles_path
  end

  protected
  def admin_user?
    redirect_to root_path() unless user_signed_in? && current_user.admin?
  end
end
