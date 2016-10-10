class Staff::TeamSchedule < ActiveRecord::Base
  belongs_to :home_team, foreign_key: 'home_team_id', class_name: 'Team'
  belongs_to :away_team, foreign_key: 'away_team_id', class_name: 'Team'
  has_many :staff_groups, class_name: 'Staff::Group'
end
