class Staff::MatchReportsController < StaffController
  def show
    @staff_team_schedule = Staff::TeamSchedule.find params[:team_schedule_id]
    @staff_match_report = Staff::MatchReport.find params[:id]
  end

  def new
    @staff_team_schedule = Staff::TeamSchedule.find params[:team_schedule_id]

    @home_team_players = TeamPlayer.where(team_id: @staff_team_schedule.home_team_id)
    @away_team_players = TeamPlayer.where(team_id: @staff_team_schedule.away_team_id)
    @players = @home_team_players + @away_team_players

    @staff_match_report ||= Staff::MatchReport.new
    render
  end

  def create
    @staff_team_schedule = Staff::TeamSchedule.find params[:team_schedule_id]
    @staff_match_report = Staff::MatchReport.new staff_match_report_params
    if @staff_match_report.save
      @staff_match_report.update_attribute(:staff_team_schedule_id, @staff_team_schedule.id)
      redirect_to staff_zone_group_team_schedule_match_report_path(id:@staff_match_report), notice: "Disimpan."
    else
      render 'new'
    end
  end

  private

    def staff_match_report_params
      params.require(:staff_match_report).permit(:team_schedule_id, :best_player_id, :cuaca, :jumlah_penonton, :pengadil, :catatan, :score_home_team, :score_away_team)
    end
end
