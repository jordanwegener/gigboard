class Band < ApplicationRecord
  belongs_to :user
  has_many :negotiations
  validates :name, :location, :style, presence: true
end
