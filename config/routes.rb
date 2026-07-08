Rails.application.routes.draw do
  devise_for :users
  
  root "users#dashboard"
  get "dashboard", to: "users#dashboard"

  resources :leagues do
    collection do
      post :join
    end
    member do
      get :dashboard
      get :market
    end
    resources :league_drivers, only: [] do
      resource :purchase, only: [:create], module: :league_drivers
      resource :buyout, only: [:create], module: :league_drivers
      resource :sale, only: [:create], module: :league_drivers
    end
    resources :fantasy_lineups, only: [:new, :create, :edit, :update]
  end

  resources :calendars, only: [:index]
  resources :teams, only: [:index, :show, :new, :create]
  
  get 'normativa', to: 'rules#index', as: :rules
  get 'ajustes', to: 'settings#edit', as: :settings
  patch 'ajustes', to: 'settings#update'

  namespace :admin do
    resources :rallies, only: [:index, :update]
  end
end
