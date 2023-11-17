Rails.application.routes.draw do
  get 'wish_list/add_to_wish_list'
  get 'wish_list/remove_from_wish_list'
  get 'search', to: 'search#index'
  get 'home/index'
  
  resources :items do
    resources :comments
    
    member do
      post 'add_to_wish_list', to: 'wish_list#add_to_wish_list'
      delete 'remove_from_wish_list', to: 'wish_list#remove_from_wish_list'
    end
  end
   
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    registrations: 'users/registrations'

  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  match 'users/:id', to: 'users#profile', via: :get, as: 'user_profile'
  get '/users/:id/my_items', to: 'users#my_items', as: 'user_my_items'
  get '/users/:id/wish_list', to: 'users#show_wish_list', as: 'user_wish_list'
  get 'user/:id', to: 'users#profile', as: 'user'
  root 'home#index' #for log

end
