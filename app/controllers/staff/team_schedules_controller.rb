class Staff::TeamSchedulesController < StaffController
  def index
    @group = Staff::Group.find params[:group_id]
    @staff_team_schedules = Staff::TeamSchedule.where(staff_group_id: @group)
  end

  def new
    @group = Staff::Group.find params[:group_id]
    @staff_team_schedule ||= Staff::TeamSchedule.new
    render
  end

  def create
    @group = Staff::Group.find params[:group_id]
    @staff_team_schedule = Staff::TeamSchedule.new staff_team_schedule_params
    if @staff_team_schedule.save
      @staff_team_schedule.update_attribute(:staff_group_id, @group.id)
      redirect_to staff_zone_group_team_schedules_path, notice: "Berjaya diwujudkan."
    else
      render 'new'
    end
  end

  private

    def staff_team_schedule_params
      params.require(:staff_team_schedule).permit(:staff_group_id, :home_team_id, :away_team_id, :tarikh_perl, :bil_per, :pbn, :masa_perl, :venue)
    end
end
