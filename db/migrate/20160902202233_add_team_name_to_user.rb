class AddTeamNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :team_name, :string
  end
end
