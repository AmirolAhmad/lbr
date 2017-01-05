class PagesController < ApplicationController
  # layout 'dashboard'
  def table_standing
    staff_group_teams = Staff::GroupTeam.all
    @authors = staff_group_teams.group_by(&:staff_group)
  end

  def match_schedule
    staff_team_schedules = Staff::TeamSchedule.all
    @team_schedules = staff_team_schedules.group_by(&:staff_group)
    @staff_match_report = Staff::MatchReport.where(staff_team_schedule_id: @team_schedules)
  end

  def search
    @from = Date.parse(params[:from])
    @to = Date.parse(params[:to])


    staff_team_schedules = Staff::TeamSchedule.all
    @team_schedules = staff_team_schedules.where(
        :tarikh_perl => @from.beginning_of_day..@to.end_of_day).group_by(&:staff_group)
  end
end
