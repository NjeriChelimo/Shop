Giga::Application.routes.draw do
  resources :cart_items

  resources :carts

  resources :home

  post 'client_users/update_cart', :as => 'update_cart'

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  resources :organizations
  resources :accounts do
    resources :images
  end

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  #devise_for :users
  devise_for :users, :controllers => { :registrations => :registrations}
  devise_for :admin_users, :controllers => { :admin_registrations => :registrations}
  devise_for :client_users, :controllers => { :client_user_registrations => :registrations}
  resources :users
  resources :admin_users
  resources :client_users
end
