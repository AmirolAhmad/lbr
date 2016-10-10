class AddStatusToStaffTeamSchedule < ActiveRecord::Migration
  def change
    add_column :staff_team_schedules, :status, :integer
  end
end
