class CreateStaffTeamSchedules < ActiveRecord::Migration
  def change
    create_table :staff_team_schedules do |t|
      t.integer :home_team_id, index: true
      t.integer :away_team_id, index: true
      t.datetime :tarikh_perl
      t.string :bil_per
      t.string :pbn
      t.time :masa_perl
      t.string :venue

      t.timestamps null: false
    end
  end
end
