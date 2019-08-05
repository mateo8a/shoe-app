class ProductType < ApplicationRecord
  belongs_to :organization
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
