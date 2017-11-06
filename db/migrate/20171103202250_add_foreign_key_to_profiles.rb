class AddForeignKeyToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :profiles, :users
  end
end
