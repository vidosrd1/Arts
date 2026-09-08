class Post < ApplicationRecord
  has_rich_text :body
  has_one_attached :image

  def self.search(search)
    where("title LIKE ? OR
      name LIKE ?
      ",
      #OR body LIKE ?
      #name OR body LIKE ?
      #"%#{search}%",
      "%#{search}%",
      "%#{search}%")
  end

  def image_as_thumbnail
    return unless image.content_type.in?(%w[image/jpeg image/png image/jpg])
    image.variant(resize_to_limit: [300, 300]).processed
  end
end
