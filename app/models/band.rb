class Band < ApplicationRecord
  belongs_to :user
  has_many :negotiation
end
