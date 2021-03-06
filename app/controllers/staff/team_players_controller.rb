class Staff::TeamPlayersController < StaffController
  def index
    @team = Team.find(params[:team_id])
    @team_players = TeamPlayer.where(team_id: params[:team_id])
    # generate PDF
    respond_to do |format|
      format.html
      format.pdf do
        pdf = LoTeamPlayerPdf.new(@team_players, @team, view_context)
        send_data pdf.render, filename:
        "TeamPlayers-#{@team.team_name}.pdf",
        type: "application/pdf",
        disposition: "inline"
      end
    end
  end

  def show
    @team_player = TeamPlayer.find(params[:id])
    # generate PDF
    respond_to do |format|
      format.html
      format.pdf do
        pdf = TagPemainPdf.new(@team_player, view_context)
        send_data pdf.render, filename:
        "TeamPlayers-#{@team_player.player_name}.pdf",
        type: "application/pdf",
        disposition: "inline"
      end
    end
  end
end
