Giga::Application.routes.draw do
  resources :cart_items

  resources :carts

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
  devise_for :users, :controllers => { :sessions => :sessions, :registrations => :registrations}
  resources :users
end
