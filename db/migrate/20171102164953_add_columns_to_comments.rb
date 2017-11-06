class AddColumnsToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :commentable_id, :integer,  null: false
    add_column :comments, :commentable_type, :string, null: false

    add_index :comments, [:commentable_type, :commentable_id]

  end
end
