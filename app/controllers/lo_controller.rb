class LoController < ApplicationController
  layout 'dashboard'
  before_filter :require_state_manager
end
