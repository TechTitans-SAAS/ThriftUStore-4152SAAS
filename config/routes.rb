Rails.application.routes.draw do
  get 'home/index'
  resources :items
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'user/:id', to: 'users#profile', as: 'user'
  # resources :users, only: [:show] do
  #   member do
  #     get 'my_items'
  #   end
  # end
  get '/users/:id/my_items', to: 'users#my_items', as: 'user_my_items'

  root 'home#index' #for login
end
