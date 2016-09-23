class Staff::TeamOfficialsController < StaffController

  def index
    @team = Team.find(params[:team_id])
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
  end

  def show
    @team_official = TeamOfficial.find(params[:id])
  end
end
