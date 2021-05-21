class User < ApplicationRecord
  has_many :bands, dependent: :destroy
  has_many :gigs, dependent: :destroy
  validates :username, :email, :password, presence: true, uniqueness: true, format: { with: /\A\w+\z/, message: "Username may only contain alphanumeric characters" }
end
