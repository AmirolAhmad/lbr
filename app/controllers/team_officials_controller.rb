class TeamOfficialsController < ApplicationController
  layout 'dashboard'
  before_filter :require_team_manager
  before_action :authenticate_user!

  def index
    @team = current_user.team
    if current_user.state_id == @team.state_id
      @team_officials = TeamOfficial.where("team_id" => "#{current_user.team.id}")
      # generate PDF
      respond_to do |format|
        format.html
        format.pdf do
          pdf = LoTeamOfficialPdf.new(@team_officials, @team, view_context)
          send_data pdf.render, filename:
          "TeamOfficials-#{@team.team_name}.pdf",
          type: "application/pdf",
          disposition: "inline"
        end
      end
    else
      redirect_to team_path, notice: "You have no authorization to this team!"
    end
  end

  def new
    @team_official ||= TeamOfficial.new
    render
  end

  def create
    @team_official = TeamOfficial.new team_official_params
    if @team_official.save
      redirect_to team_team_officials_path, notice: "Tahniah! Pegawai berjaya diwujudkan."
    else
      render 'new'
    end
  end

  def show
    @team_official = TeamOfficial.find params[:id]
    # generate PDF
    respond_to do |format|
      format.html
      format.pdf do
        pdf = TagPegawaiPdf.new(@team_official, view_context)
        send_data pdf.render, filename:
        "TeamOfficials-#{@team_official.name}.pdf",
        type: "application/pdf",
        disposition: "inline"
      end
    end
  end

  def edit
    @team_official = TeamOfficial.find(params[:id])
    if @team_official
      render
    else
      redirect_to team_team_official_path(@team_official), notice: "Maaf! Pasukan tidak dijumpai!"
    end
  end

  def update
    @team_official = TeamOfficial.find(params[:id])
    if @team_official.update_attributes team_official_params
      redirect_to team_team_official_path(id:@team_official), notice: "Data Pegawai Pasukan berjaya dikemaskini."
    else
      render 'edit'
    end
  end

  private

    def team_official_params
      params.require(:team_official).permit(:name, :position, :team_id, :phone_number, :profile_picture, :profile_picture_cache, :ic_number, :email_address, :no_sijil, :salinan_sijil, :salinan_sijil_cache)
    end
end
