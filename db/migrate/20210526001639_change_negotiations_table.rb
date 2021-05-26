class ChangeNegotiationsTable < ActiveRecord::Migration[6.1]
  def change
    add_column :negotiations, :message, :text
    add_column :negotiations, :status, :integer
    remove_column :negotiations, :offer_price
    remove_column :negotiations, :accepted_price
    remove_column :negotiations, :accepted
  end
end
