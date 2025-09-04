class Post < ApplicationRecord
  has_rich_text :body
  has_one_attached :image

  def self.order_by_votes(show = nil)
    count = if show
      "case when votes.show_id = #{show.id} AND NOT votes.fulfilled then 1 else null end"
    else
      nullif(votes.fulfilled, true)'
    end
    left_joins(:votes).group(:id)
      .uniq!(:group)
      .select("people.*, COUNT(#{count}) as vote_count")
      .order(Arel.sql("COUNT(#{count}) DESC"))
  end

  scope :search_by_name, ->(query) {
    where("titl ILIKE ?", "%#{query}%") }
  scope :search_by_name, ->(query) { where("name ILIKE ?", "%#{query}%") }
  scope :search_by_body, ->(query) {
    where("body ILIKE ?", "%#{query}%") }

  def image_as_thumbnail
    return unless image.content_type.in?(%w[image/jpeg image/png image/jpg])
    image.variant(resize_to_limit: [300, 300]).processed
  end

  #def to_param
  #  name.blank? ? id : name
  #end
end
