class Gig < ApplicationRecord
  belongs_to :user
  has_many :negotiations, dependent: :destroy
  validates :title, :location, :start_time, :end_time, :ask_price, :active, presence: true
  after_initialize :set_default_active

  def set_default_active
    self.active = true
  end
end
