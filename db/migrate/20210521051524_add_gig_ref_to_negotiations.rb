class AddGigRefToNegotiations < ActiveRecord::Migration[6.1]
  def change
    add_reference :negotiations, :gig, null: false, foreign_key: true
  end
end
