class TeamConfigsController < ApplicationController
  layout 'dashboard'
  before_filter :require_state_manager

  def new
    @team_config ||= TeamConfig.new
    render
  end

  def create
    @user = current_user
    @team_config = TeamConfig.create team_config_params
    @user.team_config = @team_config
    if @team_config.save
      redirect_to new_team_manager_path, notice: "Tahniah!Pengurus Pasukan berjaya diwujudkan"
    else
      render 'new'
    end
  end

  def show
    @team_config = TeamConfig.find_by_state_id("#{current_user.state_id}")
  end

  private

    def team_config_params
      params.require(:team_config).permit(:state_id, :count)
    end
end
