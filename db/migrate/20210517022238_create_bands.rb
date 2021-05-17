class CreateBands < ActiveRecord::Migration[6.1]
  def change
    create_table :bands do |t|
      t.string :name
      t.string :location
      t.text :style
      t.text :description

      t.timestamps
    end
  end
end
