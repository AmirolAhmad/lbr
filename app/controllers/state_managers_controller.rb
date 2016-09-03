class StateManagersController < ApplicationController
  layout 'dashboard'
  before_filter :require_lbr_admin

  def index
    @state_managers = User.where(role: 2)
  end

  def new
    @state_manager ||= User.new
    render
  end

  def create
    @state_manager = User.new state_manager_params
    if @state_manager.save
      redirect_to state_managers_path, notice: "Well done brah! Your state manager has been create"
    else
      render 'new'
    end
  end

  private

    def state_manager_params
      params.require(:user).permit(:id, :username, :login, :email, :password, :password_confirmation, :role, :state_id)
    end
end
