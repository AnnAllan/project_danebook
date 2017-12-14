class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.references :user, null: false
      t.attachment :picture
  

      t.timestamps
    end
  end
end
