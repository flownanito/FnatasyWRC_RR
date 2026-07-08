Rails.application.routes.draw do
  devise_for :users
  
  root "users#dashboard"
  get "dashboard", to: "users#dashboard"

  resources :leagues do
    collection do
      post :join
    end
    member do
      get :market
    end
    resources :league_drivers, only: [] do
      member do
        post :buy
        post :clausulazo
        post :sell
      end
    end
    resources :fantasy_lineups, only: [:new, :create, :edit, :update]
  end

  resources :markets, only: [:index]
  resources :calendars, only: [:index]
  resources :teams, only: [:index, :show, :new, :create]
  get 'ajustes', to: 'settings#edit', as: :settings
  patch 'ajustes', to: 'settings#update'

  namespace :admin do
    resources :rallies, only: [:index, :update]
  end
end
