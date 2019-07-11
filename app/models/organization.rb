class Organization < ApplicationRecord
  has_many :users
  has_many :shoes

  validates :name, uniqueness: true
end
