class Staff::MatchReport < ActiveRecord::Base
  belongs_to :staff_team_schedule, class_name: 'Staff::TeamSchedule'
  belongs_to :best_player, foreign_key: 'best_player_id', class_name: 'TeamPlayer'

  validates :jumlah_penonton, numericality: { only_integer: true }, length: { maximum: 12 }, format: { without: /\s/ }
  validates :score_home_team, numericality: { only_integer: true }, length: { maximum: 12 }, format: { without: /\s/ }
  validates :score_away_team, numericality: { only_integer: true }, length: { maximum: 12 }, format: { without: /\s/ }
  validates :jumlah_penonton, numericality: { only_integer: true }, length: { maximum: 12 }, format: { without: /\s/ }
end
