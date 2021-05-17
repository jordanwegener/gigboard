class CreateNegotiations < ActiveRecord::Migration[6.1]
  def change
    create_table :negotiations do |t|
      t.decimal :ask_price
      t.decimal :offer_price
      t.boolean :accepted
      t.boolean :active

      t.timestamps
    end
  end
end
