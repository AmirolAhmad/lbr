class Lo::TeamOfficialsController < LoController
  def index
    @team = Team.find params[:team_id]
    if current_user.state_id == @team.state_id
      @team_officials = TeamOfficial.where(team_id: params[:team_id])
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
      redirect_to lo_teams_path, notice: "You have no authorization to this team!"
    end
  end

  def show
    @team_official = TeamOfficial.find(params[:id])
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
end
