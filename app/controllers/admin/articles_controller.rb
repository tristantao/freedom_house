class Admin::ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end
  
  def index
    @articles = Article.all
    @article_location = {}
    @articles.each do |a|
      loc = a.locations
      if not loc.size == 0
        @article_location[a.id] = loc[0].name
      else
        @article_location[a.id] = ""
      end
    end
  end
	
  def new
    article = params[:article]
    if article
     s = Article.create(:title => article[:title], :location => article[:location], :date => article[:date], :author=> article[:author], :link => article[:link], :text => article[:text])
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
  
  def delete
    @article = Article.find_by_id(params[:id])
    title = @article.title
    @article.delete
    flash[:notice] = "Article #{title} has been deleted."
    redirect_to admin_articles_path
  end

end
