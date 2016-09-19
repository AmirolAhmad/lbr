class Staff::TeamPlayersController < StaffController
  def index
    @team = Team.find(params[:team_id])
    @team_players = TeamPlayer.where(team_id: params[:team_id])
  end

  def show
    @team_player = TeamPlayer.find(params[:id])
  end

  def edit
    @team_player = TeamPlayer.find(params[:id])
    if @team_player
      render
    else
      redirect_to admin_team_team_player_path(@team_player), notice: "Maaf! Pasukan tidak dijumpai!"
    end
  end
end
