class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :organization, optional: true

  ADMIN_EMAILS = ["mateo.ochoac@gmail.com"]

  def role
    ADMIN_EMAILS.include?(email) ? "admin" : "user"
  end

  def admin?
    role == "admin"
  end
end
