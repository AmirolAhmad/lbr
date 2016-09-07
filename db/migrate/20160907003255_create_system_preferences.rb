class CreateSystemPreferences < ActiveRecord::Migration
  def change
    create_table :system_preferences do |t|
      t.datetime :start_window
      t.datetime :end_window
      t.integer :player_reg_limit

      t.timestamps null: false
    end
  end
end
