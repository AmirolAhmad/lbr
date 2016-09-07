class TeamOfficialsController < ApplicationController
  layout 'dashboard'
  before_filter :require_team_manager
  before_action :authenticate_user!

  def index
    @team_officials = TeamOfficial.where("team_id" => "#{current_user.team.id}")
  end

  def new
    @check = !TeamOfficial.exists?("team_id" => "#{current_user.team.id}")
    if @check == true
      @team_official = []
      12.times do
        @team_official << TeamOfficial.new
      end
    else
      redirect_to team_team_officials_path, notice: "Maaf. Pegawai Pasukan anda telah wujud"
    end
  end

  def create
    @team_official = params["team_officials"].each do |to|
      if to["name"] != "" || to["position"] != "" || to["phone_number"] != "" || to["ic_number"] != "" || to["email_address"] != "" || to["no_sijil"] != "" || to["salinan_sijil"] != ""
        TeamOfficial.create(team_official_params(to))
      end
    end
    redirect_to team_team_officials_path, notice: "Tahniah. Data Pegawai Pasukan anda telah berjaya dicipta."
  end

  def show
    @team_official = TeamOfficial.find params[:id]
  end

  private

    def team_official_params(my_params)
      my_params.permit(:name, :position, :phone_number, :ic_number, :email_address, :no_sijil, :salinan_sijil)
    end
end
