class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.date    :dob
      t.string  :college
      t.string  :hometown
      t.string  :location
      t.string  :phone
      t.text    :motto
      t.text    :about
      t.string  :gender


      t.timestamps
    end
  end
end
