class User < ApplicationRecord
  has_many :bands, dependent: :destroy
  has_many :gigs, dependent: :destroy
  validates :username, presence: true, uniqueness: true, format: { with: /\A[A-Za-z0-9]+\z/, message: "Username may only contain alphanumeric characters." }
  validates :password, presence: true, format: { with: /\S/, message: "Password cannot contain spaces." }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Email provided is not a valid email address." }
end
