class AddAcceptedPriceToNegotiations < ActiveRecord::Migration[6.1]
  def change
    add_column :negotiations, :accepted_price, :decimal
  end
end
