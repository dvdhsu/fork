require 'sidekiq/web'

Collegenotify::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root "pages#home"    
  get "home", to: "pages#home", as: "home"
  get "inside", to: "pages#inside", as: "inside"
  
  post "updates_subscribe", to: "updates#create"

  devise_for :users

  # sidekiq monitoring
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web, at: "/sidekiq"
  end
end
