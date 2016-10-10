class AddStaffGroupToStaffTeamSchedule < ActiveRecord::Migration
  def change
    add_reference :staff_team_schedules, :staff_group, index: true, foreign_key: true
  end
end
