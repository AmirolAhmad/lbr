class Staff::ZonesController < StaffController
  def index
    @staff_zones = Staff::Zone.all
  end
end
