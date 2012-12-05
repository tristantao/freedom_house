class TrackerController < ApplicationController
  before_filter :authenticate_user!

  def index
    @articles = Article.where("contains_hatespeech = ? AND admin_verified = ?", true, true)
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
    @links = {"hate" => admin_webscraper_action_path(:accept, @article.id), "nohate" => admin_webscraper_action_path(:reject, @article.id), "delete" => admin_articles_action_path(:delete, @article.id)}
    if @article.nil?
      render :text => t("server_error"), :status => 403
    else
      @article.text = view_context.highlight_whole_word(@article.text, @article.hateArray, :highlighter => '<strong class="highlight">\1</strong>')
      puts @article.to_json
      render :json => [@article, @links]
    end
  end
  
  def viewGraph
    count = []
    json = {}
    if !params[:start].nil? && !params[:end].nil?
      articles = Article.find(:all, :conditions => { :date => (Date.parse(params[:start])..(Date.parse(params[:end]))+1) }, :order => "date asc")
    else
      articles = Article.all(:order => "date asc")
    end
    
    if articles.length != 0
      articles.each do |article|
        count << article.date.to_date 
      end
    else
      a = Article.new() 
      a.date = DateTime.now.to_date
      articles << a
    end
    
    if params[:start].nil?
      start = articles[0].date.strftime("%d-%b-%Y")
    else
      start = params[:start]
    end
    
    if params[:end].nil?
      finish = articles[-1].date.strftime("%d-%b-%Y")
    else
      finish = params[:end]
    end
    
    startdate = Date.parse(start)
    enddate = Date.parse(finish)
    currentdate = Date.parse(start)
    
    if startdate <= enddate
      while(currentdate <= enddate) 
      
        count << currentdate
        
        currentdate+=1
      end
    end
    
    count.sort!
    count.each do |date|
      if json[date.strftime("%d-%b-%Y")].nil?
        json[date.strftime("%d-%b-%Y")] = 0
      else
        json[date.strftime("%d-%b-%Y")] += 1
      end
    end
    render :json => json
  end

end
