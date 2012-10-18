Giga::Application.routes.draw do
  resources :organizations do
    resources :accounts do
      resources :images
    end
  end

#  get "images/index"

#  get "images/new"

#  get "images/show"

#  post "images/create"

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end
