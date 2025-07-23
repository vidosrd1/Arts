class Post < ApplicationRecord
  has_rich_text :body
  has_one_attached :image

  def image_as_thumbnail
    return unless image.content_type.in?(%w[image/jpeg image/png image/jpg])
    image.variant(resize_to_limit: [300, 300]).processed
  end

  #def to_param
  #  name.blank? ? id : name
  #end
end
