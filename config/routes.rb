Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations',
    omniauth: 'users/omniauth',
    unlocks: 'users/unlocks'
  }
  devise_scope :user do
    delete 'sign_out', :to => 'users/sessions#destroy'
    get '/login' => 'users/sessions#new'
    get '/register' => 'users/registrations#new'
    get '/settings' => 'users/registrations#edit'
    root 'users/sessions#new'
  end

  get "/dashboard" => 'dashboards#index'
  resource :team, only: [:new, :create, :show] do
    resources :team_officials, only: [:index, :new, :create, :show]
    resources :team_players, only: [:index, :new, :create, :show]
  end
  resource :team_config, only: [:show, :new, :create]
  resource :state_config, only: [:show, :new, :create]
  resources :state_managers
  resources :team_managers, except: [:show]
  resource :profile, only: [:edit, :update]
  resource :system_preference, only: [:edit, :update]
end
