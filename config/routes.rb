Giga::Application.routes.draw do
  resources :organizations do
    resources :accounts do
      resources :images
    end
  end

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  #devise_for :users
  devise_for :users, :controllers => { :sessions => :sessions, :registrations => :registrations}
  resources :users
end
