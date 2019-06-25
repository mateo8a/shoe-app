class Shoe < ApplicationRecord
  validates :owner, presence: true
  validates :phone, presence: true
  validates :product_type, presence: true
  validates :color, presence: true
  validates :gender, presence: true
  validates :task_description, presence: true
  validates :cost, presence: true
  validates :type_of_payment, presence: true if paid_for
  validates :location, presence: true if finished
end
