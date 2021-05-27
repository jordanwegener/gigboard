class Band < ApplicationRecord
  belongs_to :user
  has_many :negotiations, dependent: :destroy
  validates :name, :location, :style, presence: true
end
