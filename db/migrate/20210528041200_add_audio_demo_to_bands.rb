class AddAudioDemoToBands < ActiveRecord::Migration[6.1]
  def change
    add_column :bands, :demo, :text
  end
end
