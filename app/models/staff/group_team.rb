class Staff::GroupTeam < ActiveRecord::Base
  belongs_to :team
  belongs_to :staff_group, class_name: 'Staff::Group'
  has_many :staff_team_schedules, class_name: 'Staff::TeamSchedule'

  default_scope -> { order('staff_group_teams.created_at ASC') }
end
