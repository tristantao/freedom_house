class Admin::ArticlesController < ApplicationController

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
  end

  def delete
    @article = Article.find_by_id(params[:id])
    title = @article.title
    @article.delete
    flash[:notice] = "Article #{title} has been deleted."
    redirect_to admin_articles_path
  end

end
