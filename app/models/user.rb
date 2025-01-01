class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #def to_param
  #  name.blank? ? id : name
  #end
end
