class CreateArts < ActiveRecord::Migration[8.0]
  def change
    create_table :arts do |t|
      t.string :name

      t.timestamps
    end
  end
end
