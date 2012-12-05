class Admin::ArticlesController < ApplicationController

  before_filter :admin_user?
  before_filter :authenticate_user!

  def index
    @articles = Article.where("(contains_hatespeech = ? OR contains_hatespeech = ?) AND (admin_verified = ? OR admin_verified = ?)", true, false, true, false)
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
      s = Article.create(:title => article[:title], :date => DateTime.strptime(article[:date], "%m/%d/%Y"), :link => article[:link])
      if s.save
        s.delay.scrapeAll!
        flash[:notice] = "Article #{article[:title]} has been created!"
        redirect_to admin_articles_path
      else
        flash[:warning] = s.errors.full_messages.join(". ") + "."
      end
    end
  end


  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.title = params[:article][:title]
    @article.date = DateTime.strptime(params[:article][:date], "%m/%d/%Y")
    @article.author = params[:article][:author]
    @article.location = params[:article][:location]
    @article.link = params[:article][:link]
    @article.text = params[:article][:text]
    if @article.save
      flash[:notice] = "Successfully updated article!"
    else
      flash[:warning] = @article.errors.full_messages.join(". ") + '.'
    end
    redirect_to admin_articles_action_path(:edit, @article.id)
  end



  def delete
    article = Article.find_by_id(params[:id])
    title = article.title
    article.destroy
    flash[:notice] = "Article #{title} has been deleted."
    redirect_to :back
  end

  protected
  def admin_user?
    redirect_to root_path() unless user_signed_in? && current_user.admin?
  end
end
