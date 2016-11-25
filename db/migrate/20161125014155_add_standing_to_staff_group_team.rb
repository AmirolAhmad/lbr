class AddStandingToStaffGroupTeam < ActiveRecord::Migration
  def change
    add_column :staff_group_teams, :perlawanan, :string
    add_column :staff_group_teams, :menang, :string
    add_column :staff_group_teams, :seri, :string
    add_column :staff_group_teams, :kalah, :string
    add_column :staff_group_teams, :gol_bolos, :string
    add_column :staff_group_teams, :gol_masuk, :string
    add_column :staff_group_teams, :mata, :string
  end
end
