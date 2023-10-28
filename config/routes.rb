Rails.application.routes.draw do
  root 'home#index' #for log
  get 'home/index', to: 'home#index'


  resources :items
  resources :users

  match 'users/:id', to: 'users#profile', via: :get, as: 'user_profile'




  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html



end
