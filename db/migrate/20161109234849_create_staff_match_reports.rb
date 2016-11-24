class CreateStaffMatchReports < ActiveRecord::Migration
  def change
    create_table :staff_match_reports do |t|
      t.belongs_to :staff_team_schedule, index: true, foreign_key: true
      t.string :cuaca
      t.string :jumlah_penonton
      t.integer :best_player_id, index: true, foreign_key: true
      t.integer :score_home_team
      t.integer :score_away_team
      t.string :pengadil
      t.text :catatan

      t.timestamps null: false
    end
  end
end
