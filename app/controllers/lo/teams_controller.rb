class Lo::TeamsController < LoController
  def index
    @teams = Team.where("state_id" => "#{current_user.state_id}")
  end

  def show
    @team = Team.find params[:id]
    if current_user.state_id == @team.state_id
      @team = Team.find(params[:id])
    else
      redirect_to lo_teams_path, notice: "You have no authorization to this team!"
    end
  end
end
