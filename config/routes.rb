require 'sidekiq/web'
# require 'sidekiq/cron/web'

# TODO: specs
# TOOD: constrain all admin routes like this !
class AdminConstraint
  def self.admin?(request)
    cookies = ActionDispatch::Cookies::CookieJar.build(request, request.cookies)
    return false unless cookies.encrypted[:user_id]

    user = User.find(cookies.encrypted[:user_id])
    user&.admin?
  end
end

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

  # admin
  constraints ->(request) { AdminConstraint.admin?(request) } do
    mount Sidekiq::Web => "/admin/sidekiq" # mount Sidekiq::Web in your Rails app
  end
end
