class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  belongs_to :organization, optional: true

  ADMIN_EMAILS = ["mateo.ochoac@gmail.com"]

  def admin?
    ADMIN_EMAILS.include?(email)
  end

  def superuser?
    role == "superuser" || admin?
  end
end
