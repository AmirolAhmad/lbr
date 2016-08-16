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
      redirect_to team_path, notice: "Terima kasih. Penyertaan anda telah dihantar untuk semakan."
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
    params.require(:team).permit(:team_name, :team_ref_id, :state_id, :address, :team_logo, :team_image, :status)
  end
end
