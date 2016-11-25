class RemoveTeamIdFromStaffGameStatistic < ActiveRecord::Migration
  def change
    remove_column :staff_game_statistics, :team_id, :integer
  end
end
