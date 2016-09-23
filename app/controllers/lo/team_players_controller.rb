class Lo::TeamPlayersController < LoController
  def index
    @team = Team.find params[:team_id]
    if current_user.state_id == @team.state_id
      @team_players = TeamPlayer.where(team_id: params[:team_id])
    else
      redirect_to lo_teams_path, notice: "You have no authorization to this team!"
    end
  end

  def show
    @team_player = TeamPlayer.find(params[:id])
  end
end
