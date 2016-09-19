class Staff::TeamOfficialsController < StaffController

  def index
    @team = Team.find(params[:team_id])
    @team_officials = TeamOfficial.where(team_id: params[:team_id])
  end

  def show
    @team_official = TeamOfficial.find(params[:id])
  end
end
