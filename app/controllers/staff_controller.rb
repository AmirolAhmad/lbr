class StaffController < ApplicationController
  layout 'dashboard'
  before_filter :require_view_only
end
