class ChangeColumnsForLikes < ActiveRecord::Migration[5.0]
  def change
    remove_column :likes, :post_id
    add_column    :likes, :likable_id,    :integer,  null: false
    add_column    :likes, :likable_type,  :string,   null: false

    add_index :likes, [:user_id, :likable_id, :likable_type], unique: true
    add_index :likes, :created_at
  end
end
