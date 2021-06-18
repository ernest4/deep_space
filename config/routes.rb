Rails.application.routes.draw do
  root 'home#show'

  get 'login/create', :to => 'logins#create', :as => :create_login
  get 'login/destroy', :to => 'logins#destroy', :as => :destroy_login

  get 'welcome', :to => 'welcome#index'

  get 'galaxy', :to => 'galaxy#index'

  # resources :users
  resources :characters
  # resources :matchmaking do
  #   collection do
  #     get 'cancel'
  #   end
  # end
  post 'matchmaking/create', :to => 'matchmaking#create'
  get 'matchmaking/cancel', :to => 'matchmaking#cancel'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
