Rails.application.routes.draw do
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    member do
      get :followings
      get :followers
      get :myfavorites
    end
  end

  resources :pictures, only: [:new, :edit, :create, :update, :destroy]do
    member do
      get :photoview
      get :photoshow
    end
  end
  
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  resources :photocmts, only: [:edit, :update, :create, :destroy]

end