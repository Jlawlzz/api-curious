class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name
      t.integer :echo_id
      t.integer :sc_id

      t.timestamps null: false
    end
  end
end
