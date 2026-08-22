class Article < ApplicationRecord
  async_pluck
  belongs_to :user
  has_rich_text :body
  has_many :taggables, dependent: :destroy
  has_one_attached :image
  has_many_attached :pictures
  has_many :tags, through: :taggables

  def image_as_thumbnail
    return unless image.content_type.in?(%w[image/jpeg image/png image/jpg])
    image.variant(resize_to_limit: [300, 300]).processed
  end
  def pictures_as_thumbnails
    pictures.map do |picture|
      picture.variant(resize_to_limit: [150, 150]).processed
    end
  end
  def pictures_as_thumbnails(novine)
    novine.variant(resize_to_limit: [200, 200]).processed
  end
end
