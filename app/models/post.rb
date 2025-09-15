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

#  @posts = Post.search("search query",
#    fields: [:name, :title], match: :word_start)

  #scope :search_by_name, ->(query) {
  #  where("titl ILIKE ?", "%#{query}%") }
  #scope :search_by_name, ->(query) { where("name ILIKE ?", "%#{query}%") }
  #scope :search_by_body, ->(query) {
  #  where("body ILIKE ?", "%#{query}%") }

  def image_as_thumbnail
    return unless image.content_type.in?(%w[image/jpeg image/png image/jpg])
    image.variant(resize_to_limit: [300, 300]).processed
  end

  #def to_param
  #  name.blank? ? id : name
  #end
end
