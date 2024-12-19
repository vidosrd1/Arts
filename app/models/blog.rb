class Blog < ApplicationRecord
  has_many :bloggables, dependent: :destroy
  has_many :novines, through: :bloggables

  belongs_to :parent, class_name: "Blog", optional: true  #has_many :taggables, dependent: :destroy
  has_many :subordinates, class_name: "Blog",
    foreign_key: "parent_id", :dependent => :destroy

  def to_s
    name
  end

  #def to_param
  #  name.blank? ? id : name
  #end
end
