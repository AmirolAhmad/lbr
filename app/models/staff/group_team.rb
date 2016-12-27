class Staff::GroupTeam < ActiveRecord::Base
  belongs_to :team
  belongs_to :staff_group, class_name: 'Staff::Group'
  has_many :staff_team_schedules, class_name: 'Staff::TeamSchedule'

  default_scope -> { order('staff_group_teams.mata DESC') }
  scope :by_gf, -> { order ('(staff_group_teams.gol_masuk) > (staff_group_teams.gol_bolos) ASC')}

  # class method
  def self.calc_home_gol_statistic
    @siapa = Staff::GroupTeam.all
    @siapa.each do |gol|
      @siapa1 = Staff::GroupTeam.find_by_team_id (gol)
      if Staff::MatchReport.joins(:staff_team_schedule).where("home_team_id = ?", @siapa1).exists?

        current_gm = @siapa1.gol_masuk
        current_gb = @siapa1.gol_bolos

        gm = Staff::MatchReport.joins(:staff_team_schedule).where("home_team_id = ?", @siapa1).first.score_home_team
        gb = Staff::MatchReport.joins(:staff_team_schedule).where("home_team_id = ?", @siapa1).first.score_away_team

        @siapa1.update(gol_masuk: current_gm += gm)
        @siapa1.update(gol_bolos: current_gb += gb)

      end
    end
  end

  def self.calc_away_gol_statistic
    @siapa = Staff::GroupTeam.all
    @siapa.each do |gol|
      @siapa1 = Staff::GroupTeam.find_by_team_id (gol)
      if Staff::MatchReport.joins(:staff_team_schedule).where("away_team_id = ?", @siapa1)

        current_gm = @siapa1.gol_masuk
        current_gb = @siapa1.gol_bolos

        if Staff::MatchReport.joins(:staff_team_schedule).where("away_team_id = ?", @siapa1).exists?
          gm = Staff::MatchReport.joins(:staff_team_schedule).where("away_team_id = ?", @siapa1).first.score_away_team
          gb = Staff::MatchReport.joins(:staff_team_schedule).where("away_team_id = ?", @siapa1).first.score_home_team

          @siapa1.update(gol_masuk: current_gm += gm)
          @siapa1.update(gol_bolos: current_gb += gb)
        end

      end
    end
  end
end
