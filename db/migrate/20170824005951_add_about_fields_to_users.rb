class AddAboutFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :college, :string
    add_column :users, :hoemetown, :string
    add_column :users, :currently_lives, :string
    add_column :users, :phone, :string
    add_column :users, :words_live, :text
    add_column :users, :about_me, :text

  end
end
