class StateConfigsController < ApplicationController
  layout 'dashboard'
  before_filter :require_state_manager

  def new
    @check = !StateConfig.exists?(:state_id => "#{current_user.state_id}")
    if @check == true
      @state_config ||= StateConfig.new
      render
    else
      redirect_to state_config_path, notice: "Maaf. Tetapan Pengurusan Pasukan anda telah wujud."
    end
  end

  def create
    @user = current_user
    @state_config = StateConfig.create state_config_params
    @user.state_config = @state_config
    if @state_config.save
      redirect_to new_team_manager_path, notice: "Tetapan Pengurusan Pasukan berjaya!"
    else
      render 'new'
    end
  end

  def show
    @state_config = StateConfig.find_by_state_id("#{current_user.state_id}")
  end

  private

    def state_config_params
      params.require(:state_config).permit(:state_id, :count)
    end
end
