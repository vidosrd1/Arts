class AddArtIdToLists < ActiveRecord::Migration[8.0]
  def change
    add_column :lists, :art_id, :integer
  end
end
