Rails.application.routes.draw do
  root 'home#show'

  get 'login', :to => 'logins#new' # TODO: do we need this???
  get 'login/create', :to => 'logins#create', :as => :create_login

  get 'welcome', :to => 'welcome#index'

  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
