class Lo::TeamOfficialsController < LoController
  def index
    @team = Team.find params[:team_id]
    if current_user.state_id == @team.state_id
      @team_officials = TeamOfficial.where(team_id: params[:team_id])
    else
      redirect_to lo_teams_path, notice: "You have no authorization to this team!"
    end
  end

  def show
    @team_official = TeamOfficial.find(params[:id])
  end
end
