class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :comment_dec 	
      t.references :user
      t.references :painting
      t.timestamps
    end
  end
end
