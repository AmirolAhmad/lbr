class StaffController < ApplicationController
  layout 'dashboard'
  before_filter :require_staff
end
