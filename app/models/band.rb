class Band < ApplicationRecord
  belongs_to :user
  has_many :negotiations
end
