class TeamsController < ApplicationController
  layout 'dashboard'
  before_filter :require_team_manager
  before_action :authenticate_user!

  def new
    @check = !Team.find_by_user_id("#{current_user.id}")

    if @check == TRUE
      @team ||= Team.new
      render
    else
      redirect_to team_path, notice: "Maaf. Anda telah mempunyai pasukan."
    end
  end

  def create
    @user = current_user
    @team = Team.create team_params
    @user.team = @team
    if @team.save
      redirect_to team_path, notice: "Tahniah! Pendaftaran pasukan anda telah berjaya."
    else
      render 'new'
    end
  end

  def show
    @team = Team.find_by_user_id("#{current_user.id}")
  end

  private

  def team_params
    params.require(:team).permit(:team_name, :team_ref_id, :admin_officer_id, :state_id, :address, :team_logo, :team_logo_cache, :team_image, :phone_number, :team_email_address, :team_image_cache)
  end
end
