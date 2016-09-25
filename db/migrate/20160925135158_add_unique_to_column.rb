class AddUniqueToColumn < ActiveRecord::Migration
  def change
    add_index :team_officials, :ic_number, :unique => true
    add_index :team_players, :ic_number, :unique => true
  end
end
