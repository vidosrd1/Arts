class Bloggable < ApplicationRecord
  belongs_to :novine
  belongs_to :blog
  a = Bloggable.where(blog_id: @blog_id)
  a.pluck(:novine_id)
  @novine_ids = Bloggable.where(blog_id: @log_id).map(&:novi_id)
end
