class ChangeStaffMatchReport < ActiveRecord::Migration
  def change
    remove_column :staff_match_reports, :best_player_id
    add_column :staff_match_reports, :best_player_id, :integer
    add_index :staff_match_reports, :best_player_id
    add_foreign_key :staff_match_reports, :team_players, column: :best_player_id
  end
end
