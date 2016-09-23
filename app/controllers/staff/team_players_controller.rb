class Staff::TeamPlayersController < StaffController
  def index
    @team = Team.find(params[:team_id])
    @team_players = TeamPlayer.where(team_id: params[:team_id])
  end

  def show
    @team_player = TeamPlayer.find(params[:id])
  end
end
