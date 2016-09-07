class AddFieldToTeamOfficial < ActiveRecord::Migration
  def change
    add_column :team_officials, :profile_picture, :string
    add_column :team_officials, :ref_id, :string
  end
end
