class CreatePics < ActiveRecord::Migration
  def change
    create_table :pics do |t|
      t.string :title
      t.text :description
      t.date :taken_at
      t.string :address
      t.float :latitude
      t.float :longitude
      t.text :metadata

      t.timestamps
    end
  end
end
