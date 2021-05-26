class Negotiation < ApplicationRecord
  belongs_to :gig
  belongs_to :band
  after_initialize :set_default_status

  def set_default_status
    self.active = true
    self.accepted = false
  end
end
