class AddOptionToColumn < ActiveRecord::Migration
  def change
    add_index :team_officials, :ref_id, :unique => true
    add_index :team_players, :ref_id, :unique => true
  end
end
