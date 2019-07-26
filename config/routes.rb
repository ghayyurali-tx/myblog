Rails.application.routes.draw do

  resources :users do
    resources :articles do
      resources :comments
    end
  end

  resources :articles do
    resources :likes
  end

  resources :sessions, only: [:new, :create, :destroy]

  get '/:token/confirm_email/', :to => "users#confirm_email", as: 'confirm_email'
  get "login", to: "sessions#new", as: "login"
  get "logout", to: "sessions#destroy", as: "logout"
  get "edit", to: "users#edit", as: "edit"
  get "signup", to: "users#user_new", as: "signup"


  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
