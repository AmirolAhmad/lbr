class Admin::TeamsController < AdminController

  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
  end

  def edit
    @team = Team.find(params[:id])
    if @team
      render
    else
      redirect_to admin_team_path(@team), notice: "Maaf! Pasukan tidak dijumpai!"
    end
  end

  def update
    @team = Team.find(params[:id])
    if @team.update_attributes team_params
      redirect_to admin_team_path(@team), notice: "Data Pasukan berjaya dikemaskini."
    else
      render 'edit'
    end
  end

  private

  def team_params
    params.require(:team).permit(:team_name, :team_ref_id, :admin_officer_id, :state_id, :address, :team_logo, :team_logo_cache, :team_image, :phone_number, :team_email_address, :team_image_cache)
  end
end
