class SystemPreferencesController < ApplicationController
  layout 'dashboard'
  before_filter :require_lbr_admin

  def edit
    @system_preference = SystemPreference.first
    if @system_preference
      render
    else
      redirect_to dashboard_path, notice: "Maaf, Tetapan Sistem tidak dijumpai!"
    end
  end

  def update
    @system_preference = SystemPreference.first
    if @system_preference.update system_preference_params
      redirect_to edit_system_preference_path, notice: "Tetapan Sistem anda berjaya dikemaskini."
    else
      render 'edit'
    end
  end

  def state
  end

  private

    def system_preference_params
      params.require(:system_preference).permit(:start_window, :end_window, :player_reg_limit)
    end
end
