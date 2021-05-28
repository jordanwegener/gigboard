class AddBandActiveToNegotiations < ActiveRecord::Migration[6.1]
  def change
    add_column :negotiations, :active_band, :boolean
  end
end
