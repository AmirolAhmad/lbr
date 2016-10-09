class Staff::GroupsController < StaffController
  def index
    @zone = Staff::Zone.find params[:zone_id]
    @staff_groups = Staff::Group.where(staff_zone_id: @zone)
  end

  def new
    @zone = Staff::Zone.find params[:zone_id]
    @staff_group ||= Staff::Group.new
    render
  end

  def create
    @zone = Staff::Zone.find params[:zone_id]
    @staff_group = Staff::Group.new team_staff_group_params
    if @staff_group.save
      @staff_group.update_attribute(:staff_zone_id, @zone.id)
      redirect_to staff_zone_groups_path, notice: "Kumpulan berjaya diwujudkan."
    else
      render 'new'
    end
  end

  private

    def team_staff_group_params
      params.require(:staff_group).permit(:name, :staff_zone_id)
    end
end
