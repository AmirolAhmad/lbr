class AddUserIdToTeamConfig < ActiveRecord::Migration
  def change
    add_reference :team_configs, :user, index: true, foreign_key: true
  end
end
