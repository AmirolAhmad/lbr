class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :full_name
      t.string :ic_number
      t.string :phone_number

      t.timestamps null: false
    end
  end
end
