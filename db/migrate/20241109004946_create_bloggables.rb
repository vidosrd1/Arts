class CreateBloggables < ActiveRecord::Migration[8.0]
  def change
    create_table :bloggables do |t|
      t.belongs_to :novine, null: false, foreign_key: true
      t.belongs_to :blog, null: false, foreign_key: true

      t.timestamps
    end
  end
end
