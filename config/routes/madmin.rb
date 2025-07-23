# Below are the routes for madmin
namespace :madmin do
  namespace :action_text do
    resources :encrypted_rich_texts
  end
  namespace :action_text do
    resources :rich_texts
  end
  namespace :active_storage do
    resources :attachments
  end
  namespace :active_storage do
    resources :variant_records
  end
  resources :users
  resources :novines
  resources :arts
  resources :blogs
  resources :bloggables
  resources :posts
  resources :lists
  namespace :active_storage do
    resources :blobs
  end
  root to: "dashboard#show"
end
