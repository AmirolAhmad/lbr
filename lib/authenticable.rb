module Authenticable
  extend ActiveSupport::Concern
  included do
    helper_method :require_admin, :store_location, :redirect_back_or_default, :get_redirect_back_or_default, :require_user
  end

  private
  def require_admin
    unless current_user.try(:admin?)
      flash.notice = "Admin permissions required to access this page."
      redirect_to dashboard_path
    end
  end
end
