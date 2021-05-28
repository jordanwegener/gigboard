class Negotiation < ApplicationRecord
  belongs_to :gig
  belongs_to :band
  after_initialize :set_default_status
  enum status: { pending: 0, accepted: 1, rejected: 2, paid: 3 }

  def set_default_status
    if self.new_record?
      self.active = true
      self.active_band = true
      self.status = "pending"
    end
  end
end
