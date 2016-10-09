class CreateStaffZones < ActiveRecord::Migration
  def change
    create_table :staff_zones do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
