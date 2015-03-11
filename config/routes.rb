Rails.application.routes.draw do
  get 'alerts/show'

  get 'getting-started' => 'onboarding#index'
  get 'dashboard' => 'dashboard#index'
  get 'pay-what-you-want' => 'payments#new'
  post 'payments' => 'payments#create'
  get 'subscription' => 'payments#show'
  delete 'payments' => 'payments#destroy'
  get 'start' => 'registrations#sign_up'

  post 'toys' => 'toys#search'

  resources :children, only: [:create] do
    resources :toys, on: :member
    resources :alerts, on: :member do
      post 'setup_demo', on: :collection
    end
  end

  resources :alerts, only: [:destroy]

  namespace 'api' do
    get 'gender/guess' => 'gender#guess'
    put 'volatile_session/store' => 'volatile_session#store'
  end

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'registrations',
  },
    path: 'account',
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      sign_up: 'start',
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
