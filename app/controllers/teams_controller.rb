class TeamsController < ApplicationController
  layout 'dashboard'
  before_filter :require_team_manager
  before_action :authenticate_user!

  def new
    @team = Team.find_by_admin_officer_id("#{current_user.id}")

    @team ||= Team.new
    if @team == TRUE
      render
    else
      redirect_to team_path, notice: "Sorry. you already have a team"
    end
  end

  def create
    @user = current_user
    @team = Team.create team_params
    @user.team = @team
    if @team.save
      redirect_to team_path, notice: "Pendaftaran pasukan anda telah berjaya dihantar untuk semakan."
    else
      render 'new'
    end
  end

  def show
    @team = Team.find_by_admin_officer_id("#{current_user.id}")
  end

  private

  def team_params
    params.require(:team).permit(:team_name, :team_ref_id, :admin_officer_id, :general_coordinator_id, :state_id, :address, :team_logo, :team_logo_cache, :team_image, :phone_number, :team_email_address, :team_image_cache, :status, team_officials_attributes: [:name, :position], teams_attributes: [])
  end
end
