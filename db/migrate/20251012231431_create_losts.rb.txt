class CreateLosts < ActiveRecord::Migration[8.0]
  def change
    create_table :losts do |t|
      t.string :title
      t.text :description
      t.string :thumbnail_url
      t.string :video_url
      t.boolean :pro

      t.timestamps
    end
  end
end
