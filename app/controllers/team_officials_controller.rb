class TeamOfficialsController < ApplicationController
  layout 'dashboard'
  before_filter :require_team_manager
  before_action :authenticate_user!

  def index
    @team_officials = TeamOfficial.where("teamoffable_id" => "#{current_user.team.id}")
  end

  def new
    @check = !TeamOfficial.exists?("teamoffable_id" => "#{current_user.team.id}")
    if @check == true
      @team_official = []
      12.times do
        @team_official << TeamOfficial.new(teamoffable_id: params[:teamoffable_id], teamoffable_type: params[:teamoffable_type])
      end
    else
      redirect_to team_team_officials_path, notice: "Sorry.Your team official is already exists"
    end
  end

  def create
    @team_official = params["team_officials"].each do |to|
      if to["name"] != "" || to["position"] != "" || to["phone_number"] != "" || to["ic_number"] != "" || to["email_address"] != "" || to["no_sijil"] != "" || to["salinan_sijil"] != ""
        TeamOfficial.create(team_official_params(to))
      end
    end
    redirect_to team_team_officials_path, notice: "Well done brah! Your team manager has been create"
  end

  def show
    # @team_official = TeamOfficial.find params[:id]
  end

  private

    def team_official_params(my_params)
      my_params.permit(:name, :position, :phone_number, :ic_number, :email_address, :no_sijil, :salinan_sijil, :teamoffable_id, :teamoffable_type)
    end
end
