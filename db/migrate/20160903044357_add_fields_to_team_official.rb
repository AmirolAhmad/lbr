class AddFieldsToTeamOfficial < ActiveRecord::Migration
  def change
    add_column :team_officials, :no_sijil, :string
    add_column :team_officials, :salinan_sijil, :string
  end
end
