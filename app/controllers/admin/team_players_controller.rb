class Admin::TeamPlayersController < AdminController

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

  def edit
    @team_player = TeamPlayer.find(params[:id])
    if @team_player
      render
    else
      redirect_to admin_team_team_player_path(@team_player), notice: "Maaf! Pasukan tidak dijumpai!"
    end
  end

  def update
    @team_player = TeamPlayer.find(params[:id])
    if @team_player.update_attributes team_player_params
      redirect_to admin_team_team_player_path(id:@team_player), notice: "Data Pemain Pasukan berjaya dikemaskini."
    else
      render 'edit'
    end
  end

  private

    def team_player_params
      params.require(:team_player).permit(:player_name, :player_picture, :player_picture_cache, :ic_number, :ic_picture, :ic_picture_cache, :dob, :position, :jersey_no, :team_id)
    end
end
