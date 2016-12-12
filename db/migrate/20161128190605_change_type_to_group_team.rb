class ChangeTypeToGroupTeam < ActiveRecord::Migration
  def change
    remove_column :staff_group_teams, :perlawanan
    remove_column :staff_group_teams, :menang
    remove_column :staff_group_teams, :seri
    remove_column :staff_group_teams, :kalah
    remove_column :staff_group_teams, :gol_masuk
    remove_column :staff_group_teams, :gol_bolos
    remove_column :staff_group_teams, :mata

    add_column :staff_group_teams, :perlawanan, :integer, default: 0
    add_column :staff_group_teams, :menang, :integer, default: 0
    add_column :staff_group_teams, :seri, :integer, default: 0
    add_column :staff_group_teams, :kalah, :integer, default: 0
    add_column :staff_group_teams, :gol_bolos, :integer, default: 0
    add_column :staff_group_teams, :gol_masuk, :integer, default: 0
    add_column :staff_group_teams, :mata, :integer, default: 0
  end
end
