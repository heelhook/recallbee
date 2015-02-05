Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  mount Split::Dashboard, :at => 'split'

  resources :blog, only: [ :index, :show ]

  get 'about' => 'site#about'
  get 'how-it-works' => 'site#how_it_works'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'site#index'
end
