class ChangeStaffTeamSchedule < ActiveRecord::Migration
  def change
    remove_column :staff_team_schedules, :home_team_id
    remove_column :staff_team_schedules, :away_team_id
    add_column :staff_team_schedules, :home_team_id, :integer
    add_index :staff_team_schedules, :home_team_id
    add_column :staff_team_schedules, :away_team_id, :integer
    add_index :staff_team_schedules, :away_team_id
  end
end
