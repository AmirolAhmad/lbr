class Staff::GroupTeamsController < StaffController
  def index
    @group = Staff::Group.find params[:group_id]
    @staff_group_teams = Staff::GroupTeam.where(staff_group_id: @group)
  end

  def new
    @group = Staff::Group.find params[:group_id]
    @staff_group_team ||= Staff::GroupTeam.new
    render
  end

  def create
    @group = Staff::Group.find params[:group_id]
    @staff_group_team = Staff::GroupTeam.new team_staff_group_params
    if @staff_group_team.save
      @staff_group_team.update_attribute(:staff_group_id, @group.id)
      redirect_to staff_zone_group_group_teams_path, notice: "Kumpulan berjaya diwujudkan."
    else
      render 'new'
    end
  end

  private

    def team_staff_group_params
      params.require(:staff_group_team).permit(:team_id, :staff_group_id)
    end
end
