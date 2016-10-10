class CreateStaffGroupTeams < ActiveRecord::Migration
  def change
    create_table :staff_group_teams do |t|
      t.belongs_to :team, index: true, foreign_key: true
      t.belongs_to :staff_group, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
