class Negotiation < ApplicationRecord
  belongs_to :gig
  belongs_to :band
  after_initialize :set_default_status

  def set_default_status
    self.active = true
    self.accepted = false
    self.ask_price = gig.ask_price
  end
end
