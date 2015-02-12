Rails.application.routes.draw do
  get 'getting-started' => 'onboarding#index'
  get 'dashboard' => 'dashboard#index'

  resources :children, only: [:create]
  resources :toys, only: [:create]

  get 'api/gender/guess' => 'api/gender#guess'
  get 'api/volatile_session/email' => 'api/volatile_session#email'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'registrations',
    },
    path: '',
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      sign_up: 'start',
      edit: 'account',
    }

  mount Split::Dashboard, :at => 'split'

  resources :blog, only: [ :index, :show ]

  get 'about' => 'site#about'
  get 'how-it-works' => 'site#how_it_works'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'site#index'
end
