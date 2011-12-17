class CreatePaintings < ActiveRecord::Migration
  def change
    create_table :paintings do |t|
      t.string :image
      t.string :title
      t.string :description
      t.references :user
      t.references :album
      t.timestamps
    end
  end
end
