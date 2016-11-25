class AddDefaultValueToShowAttribute < ActiveRecord::Migration
  def change
    change_column_default :staff_group_teams, :perlawanan, default: 0
    change_column_default :staff_group_teams, :menang, default: 0
    change_column_default :staff_group_teams, :seri, default: 0
    change_column_default :staff_group_teams, :kalah, default: 0
    change_column_default :staff_group_teams, :gol_bolos, default: 0
    change_column_default :staff_group_teams, :gol_masuk, default: 0
    change_column_default :staff_group_teams, :mata, default: 0
  end
end
