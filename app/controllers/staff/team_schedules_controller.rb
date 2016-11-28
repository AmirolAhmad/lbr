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

  def show
    @group = Staff::Group.find params[:group_id]
    @staff_team_schedule = Staff::TeamSchedule.find params[:id]
    @staff_match_report = Staff::MatchReport.where(staff_team_schedule_id: @staff_team_schedule)
    # @staff_match_report = Staff::MatchReport.find(params[:id]).where(staff_team_schedule_id: @staff_team_schedule.id)
  end

  def selection
    @group = Staff::Group.find params[:group_id]
    @staff_team_schedule = Staff::TeamSchedule.find params[:group_id]
    @home_team_players = TeamPlayer.where(team_id: @staff_team_schedule.home_team_id)
    @away_team_players = TeamPlayer.where(team_id: @staff_team_schedule.away_team_id)
    @home_team_officials = TeamOfficial.where(team_id: @staff_team_schedule.home_team_id)
    @away_team_officials = TeamOfficial.where(team_id: @staff_team_schedule.away_team_id)
    respond_to do |format|
      format.pdf do
        pdf = SelectionListPdf.new(@staff_team_schedule, @home_team_officials, @away_team_officials, @home_team_players, @away_team_players, view_context)
        send_data pdf.render, filename:
        "SelectionList-#{@staff_team_schedule.bil_per}.pdf",
        type: "application/pdf",
        disposition: "inline"
      end
    end
  end

  def edit
    @group = Staff::Group.find params[:group_id]
    @staff_team_schedule = Staff::TeamSchedule.find params[:id]
    if @staff_team_schedule
      render
    else
      redirect_to staff_zone_group_team_schedule_path(@staff_team_schedule), notice: "Maaf! Jadual perlawanan tidak dijumpai!"
    end
  end

  def update
    @group = Staff::Group.find params[:group_id]
    @staff_team_schedule = Staff::TeamSchedule.find params[:id]
    if @staff_team_schedule.update_attributes staff_team_schedule_params
      redirect_to staff_zone_group_team_schedule_path(id:@staff_team_schedule), notice: "Jadual perlawanan berjaya dikemaskini."
    else
      render 'edit'
    end
  end

  private

    def staff_team_schedule_params
      params.require(:staff_team_schedule).permit(:staff_group_id, :home_team_id, :away_team_id, :tarikh_perl, :bil_per, :pbn, :masa_perl, :venue)
    end
end
