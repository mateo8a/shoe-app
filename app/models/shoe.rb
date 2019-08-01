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
  validates :paid_for, presence: true, if: -> { type_of_payment }
  validates :location, presence: true, if: -> { finished }
  validates :finished, presence: true, if: -> { delivered }
  validates :delivered_date, presence: true, if: -> { delivered }
  validates :paid_for, presence: true, if: -> { delivered }
  validate :date_due_greater_than_date_received
  validate :admin_password_entered_if_voided
  before_validation :setup_delivered_datetime
  before_validation :set_up_updated_date_due

  belongs_to :organization

  acts_as_sequenced scope: :organization_id, column: :id_within_organization, start_at: 1000

  attr_accessor :custom_product_type, :admin_password

  def self.to_csv
    attributes = %w{id_within_organization owner phone product_type brand color gender task_description cost paid_for type_of_payment date_received date_due update_date_due updated_date_due location finished delivered delivered_date void}
    header = %w{ID Owner Phone Product\ type Brand Color Gender Task\ description Cost Paid\ for? Type\ of\ payment Date\ received Date\ due Update\ date\ due Updated\ date\ due Location Finished? Delivered? Delivered\ date Void}

    CSV.generate(headers: true) do |csv|
      csv << header

      all.each do |user|
        csv << attributes.map do |attr|
          if boolean_attributes.include?(attr)
            human_boolean(user.send(attr))
          else
            user.send(attr)
          end
        end
      end
    end
  end

  private
  def date_due_greater_than_date_received
    if date_due < date_received
      errors.add(:date_due, "can't be before date received")
    end
  end

  def admin_password_entered_if_voided
    if void != void_was
      authorized = User.where(organization: organization, role: "superuser").any? do |u|
        u.valid_password?(admin_password)
      end
      errors.add(:void, "must be authorized by an administrator") if !authorized
    end
  end

  def setup_delivered_datetime
    if !delivered_was && delivered
      self[:delivered_date] = Time.current
    elsif delivered_was && !delivered
      self[:delivered_date] = nil
    end
  end

  def set_up_updated_date_due
    if !updated_date_due_was
      self[:updated_date_due] = date_due
    end
  end

  def self.boolean_attributes
    %w{paid_for finished delivered update_due_date void}
  end

  def self.human_boolean(boolean)
    boolean ? "Yes" : "No"
  end
end
