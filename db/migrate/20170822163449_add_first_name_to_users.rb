class AddFirstNameToUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :name,            :string
    add_column    :users, :first_name,      :string
    add_column    :users, :last_name,       :string
    add_column    :users, :email,           :string
    add_column    :users, :password_digest, :string
    add_column    :users, :dob,             :datetime
    add_column    :users, :gender,          :string
  end
end
