class AddBandRefToNegotiations < ActiveRecord::Migration[6.1]
  def change
    add_reference :negotiations, :band, null: false, foreign_key: true
  end
end
