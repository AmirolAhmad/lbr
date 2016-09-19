module Authenticable
  extend ActiveSupport::Concern
  included do
    helper_method :require_lbr_admin, :require_state_manager, :require_user, :store_location, :redirect_back_or_default, :get_redirect_back_or_default
  end

  private
  def require_lbr_admin
    unless current_user.try(:lbr_admin?)
      flash.notice = "LBR Admin Level permissions required to access this page."
      redirect_to dashboard_path
    end
  end

  def require_state_manager
    unless current_user.try(:state_manager?)
      flash.notice = "State Manager Level permissions required to access this page."
      redirect_to dashboard_path
    end
  end

  def require_team_manager
    unless current_user.try(:team_manager?)
      flash.notice = "Team Manager Level permissions required to access this page."
      redirect_to dashboard_path
    end
  end

  def require_staff
    unless current_user.try(:staff?)
      flash.notice = "Staff Level permissions required to access this page."
      redirect_to dashboard_path
    end
  end

  def require_view_only
    unless current_user.try(:state_manager?) || current_user.try(:staff?)
      flash.notice = "View Level permissions required to access this page."
      redirect_to dashboard_path
    end
  end

  def require_user
    unless current_user
      store_location
      flash[:alert] = "You must be logged in to view this page."
      redirect_to login_url
      return false
    end
  end

  def store_location
    session[:return_to] = request.original_url rescue nil
  end

  def redirect_back_or_default(default)
    redirect_to (session[:return_to] || default)
    session[:return_to] = nil
  end

  def get_redirect_back_or_default(default)
    redirect = session[:return_to] ? session[:return_to] : default
  end
end
