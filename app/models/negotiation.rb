class Negotiation < ApplicationRecord
  belongs_to :gig
  belongs_to :band
  after_initialize :set_default_status
  enum status: { pending: 0, accepted: 1, rejected: 2, paid: 3 }

  def set_default_status
    self.active = true
    self.status = "pending"
  end
end
