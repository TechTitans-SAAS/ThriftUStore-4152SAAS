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
  root 'home#index' #for login
end
