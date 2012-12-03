class TrackerController < ApplicationController
  before_filter :authenticate_user!

  def index
    @articles = Article.all(:limit => 25, :order => "date desc")
    @json = ""
    Event.all.each do |event|
      @json << event.locations.to_gmaps4rails do |event, marker|
        marker.title event.name
        marker.infowindow render_to_string(:partial => "/shared/event_marker", :locals => {:object => event})
      end
    end
  end

  def viewArticle
    @article = Article.find_by_id(params[:articleID])
    if @article.nil?
      render :text => t("server_error"), :status => 403
    else
      @article.text = view_context.highlight_whole_word(@article.text, @article.hateArray, :highlighter => '<strong class="highlight">\1</strong>')
      puts @article.to_json
      render :json => @article
    end
  end
  
  def viewGraph
    count = {}
    if !params[:start].nil? && !params[:end].nil?
      articles = Article.find(:all, :conditions => { :date => (Date.parse(params[:start])..Date.parse(params[:end])) })
    else
      articles = Article.all(:order => "date asc")
    end
    articles.each do |article|
      if count[article.date.strftime("%d-%b-%Y")].nil?
        count[article.date.strftime("%d-%b-%Y")] = 1
      else
        count[article.date.strftime("%d-%b-%Y")] += 1
      end
    end
    
    render :json => count
  end

end
