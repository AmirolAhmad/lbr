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
      redirect_to new_team_manager_path, notice: "Well done brah! Your state team has been create"
    else
      render 'new'
    end
  end

  def show
    @team_config = TeamConfig.find_by_state_id("#{current_user.state_id}")
    # @team_config = TeamConfig.joins(:user).where('current_user.state_id is ?', :state_id)


    # scope :available, -> { joins(:user).where('users.state_id is eq ') }
    # User.where(:country => 'canada')
  end

  private

    def team_config_params
      params.require(:team_config).permit(:state_id, :count)
    end
end
