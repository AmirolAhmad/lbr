class TeamsController < ApplicationController
  layout 'dashboard'
  before_action :authenticate_user!

  def new
    @team ||= Team.new
    render
  end

  def create
    @user = current_user
    @team = @user.build_team team_params
    if @team.save
      redirect_to team_path, notice: "Pendaftaran pasukan anda telah berjaya dihantar untuk semakan."
    else
      render 'new'
    end
  end

  def show
    @team = current_user.team
  end

  def edit
    #code
  end

  def update
    #code
  end

  def destroy
    #code
  end

  private

  def team_params
    params.require(:team).permit(:team_name, :team_ref_id, :state_id, :address, :team_logo, :team_logo_cache, :team_image, :team_image_cache, :status, team_officials_attributes: [:name, :position])
  end
end
