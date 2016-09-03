class TeamManagersController < ApplicationController
  layout 'dashboard'
  before_filter :require_state_manager

  def index
    @team_managers = User.where(role: 3, state_id: current_user.state)
    @team_config = TeamConfig.find_by_state_id("#{current_user.state_id}")
    @total = (@team_managers.count) < (@team_config.count)
  end

  def new
    @team_managers = User.where(role: 3, state_id: current_user.state)
    @team_config = TeamConfig.find_by_state_id("#{current_user.state_id}")
    @total = (@team_managers.count) < (@team_config.count)

    @team_manager ||= User.new
    if @total == TRUE
      render
    else
      redirect_to team_managers_path, notice: "Sorry. you have reach your team limit to add"
    end
  end

  def create
    @team_manager = User.new team_manager_params
    if @team_manager.save
      redirect_to team_managers_path, notice: "Well done brah! Your team manager has been create"
    else
      render 'new'
    end
  end

  def show
    #code
  end

  private

    def team_manager_params
      params.require(:user).permit(:id, :username, :login, :email, :password, :password_confirmation, :role, :state_id, :team_name)
    end
end
