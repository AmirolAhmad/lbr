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
      resources :team_players
    end

    resources :pages, only: :index

    # sort by state
    get 't/:sort' => 'pages#state', as: 'state_index'
    get 't/:sort/team_players' => 'pages#team_player', as: 'team_player_state_index'
    get 't/:sort/team_officials' => 'pages#team_official', as: 'team_official_state_index'
  end

  namespace :staff, path: '/submaster' do
    resources :teams, only: [:index, :show] do
      resources :team_officials, only: [:index, :show]
      resources :team_players, only: [:index, :show]
    end
    resources :zones do
      resources :groups do
        resources :group_teams
        resources :team_schedules do
          collection do
            get :selection
          end
          resources :match_reports, except: :index
        end
      end
    end
  end

  namespace :lo, path: '/sub2master' do
    resources :teams, only: [:index, :show] do
      resources :team_officials, only: [:index, :show]
      resources :team_players, only: [:index, :show]
    end
  end

  get "/dashboard" => 'dashboards#index'
  resource :team, only: [:new, :create, :show] do
    resources :team_officials, only: [:index, :new, :create, :show, :edit, :update]
    # choose either one
    # activate new registration player
    # resources :team_players, only: [:index, :new, :create, :show, :edit, :update] do
    # de-activate new and edit player
    resources :team_players, only: [:index, :show], except: [:new, :create, :edit, :update]
  end
  resource :team_config, only: [:show, :new, :create]
  resource :state_config, only: [:show, :new, :create]
  resources :state_managers
  resources :team_managers, except: [:show]
  resource :profile, only: [:edit, :update]
  resource :system_preference, only: [:edit, :update]
end
