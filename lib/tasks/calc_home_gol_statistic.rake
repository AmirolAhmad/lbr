namespace :calc_home_gol do
  desc 'Check Reward Expired'
  task calc_home_gol_statistic: :environment do
    Staff::GroupTeam.all.each do |gol|
      if Staff::MatchReport.joins(:staff_team_schedule).where("home_team_id = ?", gol.team_id).present?
        gol.calc_home_gol_statistic
      end
    end
  end
end
