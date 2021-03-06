class TeamPlayersController < ApplicationController
  layout 'dashboard'
  before_filter :require_team_manager
  before_action :authenticate_user!

  def index
    @team = current_user.team
    if current_user.state_id == @team.state_id
      @team_players = TeamPlayer.where("team_id" => "#{current_user.team.id}")
      # generate PDF
      respond_to do |format|
        format.html
        format.pdf do
          pdf = LoTeamPlayerPdf.new(@team_players, @team, view_context)
          send_data pdf.render, filename:
          "TeamPlayers-#{@team.team_name}.pdf",
          type: "application/pdf",
          disposition: "inline"
        end
      end
    else
      redirect_to team_path, notice: "You have no authorization to this team!"
    end
  end

  def new
    @team_player ||= TeamPlayer.new
    render
  end

  def create
    @team_player = TeamPlayer.new team_player_params
    if @team_player.save
      redirect_to team_team_players_path, notice: "Tahniah! Pemain berjaya diwujudkan."
    else
      render 'new'
    end
  end

  def edit
    @team_player = TeamPlayer.find(params[:id])
    if @team_player
      render
    else
      redirect_to team_team_player_path(@team_player), notice: "Maaf! Pasukan tidak dijumpai!"
    end
  end

  def change_players
    @all = TeamPlayer.where("team_id" => "#{current_user.team.id}")
    @reject_players = @all.where("status = ?", 1)
    @new_players = @all.where("status = ?", 3)
  end

  def update
    @team_player = TeamPlayer.find(params[:id])
    if @team_player.update_attributes team_player_params
      redirect_to team_team_player_path(id:@team_player), notice: "Data Pemain Pasukan berjaya dikemaskini."
    else
      render 'edit'
    end
  end

  def show
    @team_player = TeamPlayer.find params[:id]
  end

  def mark_reject
    @team_player = TeamPlayer.find(params[:id])
    @team_player.update_attributes(status: 1)
    redirect_to team_team_players_path
  end

  private

    def team_player_params
      params.require(:team_player).permit(:player_name, :player_picture, :player_picture_cache, :ic_number, :ic_picture, :ic_picture_cache, :dob, :position, :jersey_no, :team_id)
    end
end
