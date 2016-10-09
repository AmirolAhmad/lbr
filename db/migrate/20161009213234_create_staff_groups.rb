class CreateStaffGroups < ActiveRecord::Migration
  def change
    create_table :staff_groups do |t|
      t.string :name
      t.belongs_to :staff_zone

      t.timestamps null: false
    end
  end
end
