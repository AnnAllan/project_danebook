class AddColumnsToProfile < ActiveRecord::Migration[5.0]
  def change
    remove_column :profiles, :dob
    add_column    :profiles, :dob_day,    :integer
    add_column    :profiles, :dob_month,  :integer
    add_column    :profiles, :dob_year,   :integer

  end
end
