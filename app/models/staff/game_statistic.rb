class Staff::GameStatistic < ActiveRecord::Base
  belongs_to :kod
  belongs_to :staff_match_report, :class_name => "Staff::MatchReport"
  belongs_to :team_player
end
