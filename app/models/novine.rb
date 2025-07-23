class Novine < ApplicationRecord
  async_pluck
  belongs_to :user
  has_many :bloggables, dependent: :destroy
  has_many :blogs, through: :bloggables
  #has_many :bloggables,
  #through: :blogs, source: :novines
  has_one_attached :image
  has_many_attached :pictures, dependent: :destroy
  #has_many_attached :pictures
  has_rich_text :body
  accepts_nested_attributes_for :blogs, allow_destroy: true,
   :reject_if => lambda { |n| n[:name].blank? }

  def related_articles
    Novine.joins(:blogs).where(blogs: {
      id: self.blogs.pluck(:id) }).where.not(id: self.id)
  end

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
  #def to_param
  #  name.blank? ? id : name
  #end
end
