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

  namespace :admin, path: '/master' do
    resources :teams do
      resources :team_officials
      resources :team_players do
        collection do
          get :selection
        end
      end
    end
  end

  namespace :staff, path: '/submaster' do
    resources :teams, only: [:index, :show] do
      resources :team_officials, only: [:index, :show]
      resources :team_players, only: [:index, :show] do
        collection do
          get :selection
        end
      end
    end
    resources :zones do
      resources :groups
    end
  end

  namespace :lo, path: '/sub2master' do
    resources :teams, only: [:index, :show] do
      resources :team_officials, only: [:index, :show]
      resources :team_players, only: [:index, :show] do
        member do
          get :selection
        end
      end
    end
  end

  get "/dashboard" => 'dashboards#index'
  resource :team, only: [:new, :create, :show] do
    resources :team_officials, only: [:index, :new, :create, :show, :edit, :update]
    # choose either one
    # activate new registration player
    # resources :team_players, only: [:index, :new, :create, :show, :edit, :update] do
    # de-activate new and edit player
    resources :team_players, only: [:index, :show], except: [:new, :create, :edit, :update] do
      member do
        get :selection
      end
    end
  end
  resource :team_config, only: [:show, :new, :create]
  resource :state_config, only: [:show, :new, :create]
  resources :state_managers
  resources :team_managers, except: [:show]
  resource :profile, only: [:edit, :update]
  resource :system_preference, only: [:edit, :update]
end
