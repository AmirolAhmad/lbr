class AddIndexes < ActiveRecord::Migration
  def change
    add_index :staff_groups, :staff_zone_id
  end
end
