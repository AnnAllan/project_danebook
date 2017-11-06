class RemoveColumnsFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :gender, :string
    remove_column :users, :college, :string
    remove_column :users, :hometown, :string
    remove_column :users, :currently_lives, :string
    remove_column :users, :phone, :string
    remove_column :users, :words_live, :text
    remove_column :users, :about_me, :text

  end
end
