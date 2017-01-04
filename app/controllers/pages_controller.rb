class PagesController < ApplicationController
  # layout 'dashboard'
  def table_standing
    staff_group_teams = Staff::GroupTeam.all
    @authors = staff_group_teams.group_by(&:staff_group)
  end
end
