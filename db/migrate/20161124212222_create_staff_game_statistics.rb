class CreateStaffGameStatistics < ActiveRecord::Migration
  def change
    create_table :staff_game_statistics do |t|
      t.belongs_to :kod, index: true, foreign_key: true
      t.belongs_to :staff_match_report, index: true, foreign_key: true
      t.belongs_to :team_player, index: true, foreign_key: true
      t.belongs_to :team, index: true, foreign_key: true
      t.integer :minute
      t.integer :count

      t.timestamps null: false
    end
  end
end
