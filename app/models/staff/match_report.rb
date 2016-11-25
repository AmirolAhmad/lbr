class Staff::MatchReport < ActiveRecord::Base
  belongs_to :staff_team_schedule, class_name: 'Staff::TeamSchedule'
  belongs_to :best_player, foreign_key: 'best_player_id', class_name: 'TeamPlayer'
  has_many :staff_game_statistics, class_name: 'Staff::GameStatistic', :foreign_key => 'staff_match_report_id'

  accepts_nested_attributes_for :staff_game_statistics, reject_if: :all_blank, allow_destroy: true

  validates_numericality_of :jumlah_penonton
  validates_numericality_of :score_home_team
  validates_numericality_of :score_away_team
end
