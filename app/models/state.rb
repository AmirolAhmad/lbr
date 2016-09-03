class State < ActiveRecord::Base
  has_many :teams
  has_many :team_configs
  has_one :user

  scope :available, -> { joins(:user).where('users.state_id is not null') }
end
