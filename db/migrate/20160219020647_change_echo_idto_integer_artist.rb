class ChangeEchoIdtoIntegerArtist < ActiveRecord::Migration
  def change
    change_column :artists, :echo_id,  :string
  end
end
