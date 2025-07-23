class Art < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :lists

  #def to_param
  #  name.blank? ? id : name
  #end
end
