class Admin::PagesController < AdminController
  layout 'dashboard'
  before_filter :require_lbr_admin
  before_filter :set_state, only: [:state, :team_player, :team_official]
  before_filter :set_team, only: [:state]

  def index
    @teams = Team.all
  end

  def state
  end

  def team_player
    @team_players = TeamPlayer.by_state(@state.id)
  end

  def team_official
    @team_officials = TeamOfficial.by_state(@state.id)
  end

  private

    def set_state
      @state = State.find params[:sort]
    end

    def set_team
      @teams = Team.by_state(@state.id)
    end
end
