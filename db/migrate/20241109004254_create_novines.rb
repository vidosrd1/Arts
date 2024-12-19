class CreateNovines < ActiveRecord::Migration[8.0]
  def change
    create_table :novines do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :name
      t.date :publish

      t.timestamps
    end
  end
end
