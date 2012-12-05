Freedom::Application.routes.draw do

  devise_for :users, :path =>'', :path_names => { :sign_in => 'login', :sign_out => 'logout' }

  as :user do
    root :to => 'home#index'
  end

  match 'profile' => 'user#profile',            :as => :user_profile
  match 'profile/update/:id' => 'user#update',  :as => :user_update
  match 'admin' => 'admin/dashboard#index',     :as => :admin_dashboard

  match 'home' => 'tracker#index', :as => :home


  %w{users sources articles events webscraper feedbacks classifier}.each do |i|
    match "/admin/#{i}", :to => "admin/#{i}#index", :as => "admin_#{i}"
    match "/admin/#{i}(/:action(/:id))", :to => "admin/#{i}", :action => nil, :id => nil, :format => false, :as => "admin_#{i}_action"
  end


  match 'feedbacks' => 'feedbacks#index', :as => "feedbacks_index"
  match 'feedbacks/(/:action(/:id))' => 'feedbacks', :action=> nil, :id=> nil, :format => false, :as => "feedbacks_action"
  match 'viewArticle', :to => "tracker#viewArticle", :as => "view_article"

  match '/home/viewGraph(/:start/:end)', :to => "tracker#viewGraph", :start => nil, :end => nil, :as => 'view_graph'

  match 'feedbacks/view/:feedback_id/responses/(:action)' => 'responses', :action => nil, :id=> nil, :as => "responses_action"
  match 'admin/feedbacks/view/:feedback_id/responses/(:action)' => 'admin/responses', :action => nil, :id =>nil, :as=> "admin_responses_action"


end
