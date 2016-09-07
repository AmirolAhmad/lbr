class State < ActiveRecord::Base
  has_one :user
  has_many :teams
  has_many :state_configs
  has_many :team_configs

  scope :available, -> { joins(:user).where('users.state_id is not null') }
end
