class User < ApplicationRecord
  has_many :bands
  has_many :gigs
end
