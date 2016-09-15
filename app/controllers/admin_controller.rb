class AdminController < ApplicationController
  layout 'dashboard'
  before_filter :require_lbr_admin
end
