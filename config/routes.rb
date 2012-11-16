Freedom::Application.routes.draw do

  devise_for :users, :path =>'', :path_names => { :sign_in => 'login', :sign_out => 'logout' }

  as :user do
    root :to => 'home#index'
  end

  match 'profile' => 'user#profile',            :as => :user_profile
  match 'profile/update/:id' => 'user#update',  :as => :user_update
  match 'admin' => 'admin/dashboard#index',     :as => :admin_dashboard
#  match 'admin/sources/' => 'admin/sources#index', :as => :admin_dashboard_sources
#  match 'admin/sources/new' => 'admin/sources#new', :as => :admin_dashboard_add_source

  match 'home' => 'tracker#index', :as => :home

  # Admin/XController
  %w{users articles sources events}.each do |i|
    match "/admin/#{i}", :to => "admin/#{i}#index", :as => "admin_#{i}"
    match "/admin/#{i}(/:action(/:id))", :to => "admin/#{i}", :action => nil, :id => nil, :format => false, :as => "admin_#{i}_action"
  end

end
