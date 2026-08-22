class CreateTaggables < ActiveRecord::Migration[8.1]
  def change
    create_table :taggables do |t|
      t.belongs_to :article, null: false, foreign_key: true
      t.belongs_to :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
