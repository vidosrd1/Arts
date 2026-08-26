# Below are the routes for madmin
namespace :madmin do
  resources :arts
  resources :articles
  namespace :active_storage do
    resources :attachments
  end
  namespace :active_storage do
    resources :variant_records
  end
  namespace :active_storage do
    resources :blobs
  end
  resources :lists
  resources :posts
  resources :tags
  resources :taggables
  resources :users
  namespace :action_text do
    resources :rich_texts
  end
  namespace :action_text do
    resources :encrypted_rich_texts
  end
  root to: "dashboard#show"
end
