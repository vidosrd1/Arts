json.extract! post, :id, :title, :name, :body, :created_at, :updated_at
json.url post_url(post, format: :json)
json.body post.body.to_s
