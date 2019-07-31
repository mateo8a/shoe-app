class Organization < ApplicationRecord
  has_many :users
  has_many :shoes
  has_many :product_types

  validates :name, uniqueness: true
end
