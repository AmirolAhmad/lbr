class CreateTeamPlayers < ActiveRecord::Migration
  def change
    create_table :team_players do |t|
      t.belongs_to :team, index: true, foreign_key: true
      t.string :player_name
      t.string :player_picture
      t.string :ic_number
      t.string :ic_picture
      t.datetime :dob
      t.string :position
      t.integer :jersey_no
      t.integer :status

      t.timestamps null: false
    end
  end
end
