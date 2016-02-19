class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
      t.integer :echo_id
      t.integer :sc_id
      t.string :sc_stream

      t.timestamps null: false
    end
  end
end
