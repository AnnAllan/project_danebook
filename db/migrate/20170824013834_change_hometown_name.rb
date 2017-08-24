class ChangeHometownName < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :hoemetown, :string
    add_column :users, :hometown, :string
  end
end
