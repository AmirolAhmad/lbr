class Staff::MatchReportsController < StaffController
  def show
    @group = Staff::Group.find params[:group_id]
    @staff_team_schedule = Staff::TeamSchedule.find params[:team_schedule_id]
    @staff_match_report = Staff::MatchReport.find params[:id]
  end

  def new
    @staff_team_schedule = Staff::TeamSchedule.find params[:team_schedule_id]

    @home_team_players = TeamPlayer.where(team_id: @staff_team_schedule.home_team_id)
    @away_team_players = TeamPlayer.where(team_id: @staff_team_schedule.away_team_id)
    @players = @home_team_players + @away_team_players

    @staff_match_report = Staff::MatchReport.new
    @staff_match_report.staff_game_statistics.build
    render
  end

  def create
    @staff_team_schedule = Staff::TeamSchedule.find params[:team_schedule_id]
    @staff_match_report = Staff::MatchReport.new staff_match_report_params
    if @staff_match_report.save
      @staff_match_report.update_attributes(staff_team_schedule_id: @staff_team_schedule.id)
      redirect_to staff_zone_group_team_schedule_match_report_path(id:@staff_match_report), notice: "Disimpan."
    else
      render 'new'
    end
  end

  def edit
    @group = Staff::Group.find params[:group_id]
    @staff_team_schedule = Staff::TeamSchedule.find params[:team_schedule_id]
    @staff_match_report = Staff::MatchReport.find params[:id]
    if @staff_match_report
      render
    else
      redirect_to staff_zone_group_team_schedule_match_report_path(id:@staff_match_report), notice: "Maaf! Keputusan perlawanan tidak dijumpai!"
    end
  end

  def update
    @group = Staff::Group.find params[:group_id]
    @staff_team_schedule = Staff::TeamSchedule.find params[:team_schedule_id]
    @staff_match_report = Staff::MatchReport.find params[:id]
    if @staff_match_report.update_attributes staff_match_report_params
      redirect_to staff_zone_group_team_schedule_match_report_path(id:@staff_match_report), notice: "Keputusan perlawanan berjaya dikemaskini."
    else
      render 'edit'
    end
  end

  private

    def staff_match_report_params
      params.require(:staff_match_report).permit(:team_schedule_id, :best_player_id, :cuaca, :jumlah_penonton, :pengadil, :catatan, :score_home_team, :score_away_team, staff_game_statistics_attributes: [
        :id, :kod_id, :staff_match_report_id, :team_player_id, :team_id, :minute, :count
        ])
    end
end
