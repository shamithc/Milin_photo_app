class CreateRoleUsers < ActiveRecord::Migration
  def change
    create_table :role_users do |t|
      t.references :user
      t.references :role
      t.timestamps
    end
  end
end
