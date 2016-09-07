class AddPlayerRefIdToTeamPlayer < ActiveRecord::Migration
  def change
    add_column :team_players, :ref_id, :string, unique: true
  end
end
