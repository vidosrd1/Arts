class Taggable < ApplicationRecord
  belongs_to :article
  belongs_to :tag
  a = Taggable.where(tag_id: @tag_id)
  a.pluck(:article_id)
  @article_ids = Taggable.where(tag_id: @log_id).map(&:novi_id)
end
