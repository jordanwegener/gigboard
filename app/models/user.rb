class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :bands, dependent: :destroy
  has_many :gigs, dependent: :destroy
  validates :password, presence: true, format: { with: /\S/, message: "Password cannot contain spaces." }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Email provided is not a valid email address." }
end
