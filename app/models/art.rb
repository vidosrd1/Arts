class Art < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :lists
  belongs_to :superpower

  def self.search(search)
    where("name LIKE ? ",
      "%#{search}%")
  end

  #def self.search(search)
  #  if search
  #    superpower = Superpower.find_by(name: search)
  #    if superpower
  #      self.where(superpower_id: superpower)
  #    else
  #      Art.all
  #    end
  #  else
  #    Art.all
  #  end
  #end

  #def to_param
  #  name.blank? ? id : name
  #end
end
