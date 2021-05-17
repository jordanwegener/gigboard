class CreateGigs < ActiveRecord::Migration[6.1]
  def change
    create_table :gigs do |t|
      t.string :title
      t.string :location
      t.string :start_time
      t.string :end_time
      t.decimal :ask_price
      t.boolean :active
      t.text :description

      t.timestamps
    end
  end
end
