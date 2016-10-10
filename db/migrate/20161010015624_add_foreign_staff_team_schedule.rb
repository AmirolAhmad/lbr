class AddForeignStaffTeamSchedule < ActiveRecord::Migration
  def change
    add_foreign_key :staff_team_schedules, :teams, column: :home_team_id
    add_foreign_key :staff_team_schedules, :teams, column: :away_team_id
  end
end
