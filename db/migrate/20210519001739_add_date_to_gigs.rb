class AddDateToGigs < ActiveRecord::Migration[6.1]
  def change
    add_column :gigs, :date, :string
  end
end
