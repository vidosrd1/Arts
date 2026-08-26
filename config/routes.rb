Rails.application.routes.draw do
  draw :madmin
  resources :tags
  resources :articles
  resources :lists
  resources :arts
  devise_for :users
  resources :posts
  get "home/index"
  get '/pricing', to: 'home#pricing'
  get '/privacy', to: 'home#privacy'
  get '/terms', to: 'home#terms'
  get '/about', to: 'home#about'
  get "up" => "rails/health#show", as: :rails_health_check
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  root "home#index"
  # root "posts#index"
end
