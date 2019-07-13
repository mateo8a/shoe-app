require 'csv'

class Shoe < ApplicationRecord
  validates :owner, presence: true
  validates :phone, presence: true
  validates :product_type, presence: true
  validates :color, presence: true
  validates :gender, presence: true
  validates :task_description, presence: true
  validates :cost, presence: true
  validates :type_of_payment, presence: true, if: -> { paid_for }
  validates :paid_for, presence: { message: "- Si el tipo de pago esta especificado, se debe marcar el item como pagado." }, if: -> { type_of_payment }
  validates :location, presence: true, if: -> { finished }
  validates :finished, presence: true, if: -> { delivered }

  belongs_to :organization

  def self.to_csv
    attributes = %w{id owner phone product_type brand color gender task_description cost paid_for type_of_payment date_received date_due location finished delivered}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
  end
end
