class Staff::TeamSchedule < ActiveRecord::Base
  enum status: [:incoming, :played, :postpone, :cancel]
  belongs_to :home_team, foreign_key: 'home_team_id', class_name: 'Team'
  belongs_to :away_team, foreign_key: 'away_team_id', class_name: 'Team'
  has_many :staff_groups, class_name: 'Staff::Group'

  after_initialize :set_schedule_status, :if => :new_record?

  validates_presence_of :home_team_id, :away_team_id, :bil_per, :pbn, :tarikh_perl, :masa_perl, :venue

  def set_schedule_status
    self.status ||= :incoming
  end
end
