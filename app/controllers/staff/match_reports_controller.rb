class Staff::MatchReportsController < StaffController
  def show
    @group = Staff::Group.find params[:group_id]
    @staff_team_schedule = Staff::TeamSchedule.find params[:team_schedule_id]
    @staff_match_report = Staff::MatchReport.find params[:id]
  end

  def new
    @staff_team_schedule = Staff::TeamSchedule.find params[:team_schedule_id]

    @home_team_players = TeamPlayer.where(team_id: @staff_team_schedule.home_team_id)
    @away_team_players = TeamPlayer.where(team_id: @staff_team_schedule.away_team_id)
    @players = @home_team_players + @away_team_players

    @staff_match_report = Staff::MatchReport.new
    @staff_match_report.staff_game_statistics.build
    render
  end

  def create
    @staff_team_schedule = Staff::TeamSchedule.find params[:team_schedule_id]
    @staff_match_report = Staff::MatchReport.new staff_match_report_params
    if @staff_match_report.save
      @staff_match_report.update_attributes(staff_team_schedule_id: @staff_team_schedule.id)

      @siapa1 = Staff::GroupTeam.find_by_team_id (@staff_team_schedule.home_team_id)
      @siapa2 = Staff::GroupTeam.find_by_team_id (@staff_team_schedule.away_team_id)

        current_home_gm = @siapa1.gol_masuk
        current_home_gb = @siapa1.gol_bolos
        current_away_gm = @siapa2.gol_masuk
        current_away_gb = @siapa2.gol_bolos
        perlawanan_home = @siapa1.perlawanan
        perlawanan_away = @siapa2.perlawanan
        menang_home = @siapa1.menang
        menang_away = @siapa2.menang
        kalah_home = @siapa1.kalah
        kalah_away = @siapa2.kalah
        seri_home = @siapa1.seri
        seri_away = @siapa2.seri
        mata_home = @siapa1.mata
        mata_away = @siapa2.mata

        rm = @staff_match_report
        sm = rm.staff_team_schedule.home_team_id = @siapa1.team_id
        tm = Staff::MatchReport.joins(:staff_team_schedule).where("home_team_id = ?", sm)
        gm = tm.last.score_home_team

        rb = @staff_match_report
        sb = rb.staff_team_schedule.home_team_id = @siapa1.team_id
        tb = Staff::MatchReport.joins(:staff_team_schedule).where("home_team_id = ?", sb)
        gb = tb.last.score_away_team

        @siapa1.update(gol_masuk: current_home_gm += gm)
        @siapa1.update(gol_bolos: current_home_gb += gb)
        @siapa2.update(gol_masuk: current_away_gm += gb)
        @siapa2.update(gol_bolos: current_away_gb += gm)
        @siapa1.update(perlawanan: perlawanan_home += 1)
        @siapa2.update(perlawanan: perlawanan_away += 1)

        if gm > gb
          @siapa1.update(menang: menang_home += 1)
          @siapa1.update(mata: mata_home += 3)
          @siapa2.update(kalah: kalah_away += 1)
          @siapa2.update(mata: mata_away += 0)
        elsif gm < gb
          @siapa1.update(kalah: kalah_home += 1)
          @siapa1.update(mata: mata_home += 0)
          @siapa2.update(menang: menang_away += 1)
          @siapa2.update(mata: mata_away += 3)
        elsif gm == gb
          @siapa1.update(seri: seri_home += 1)
          @siapa2.update(seri: seri_away += 1)
          @siapa1.update(mata: mata_home += 1)
          @siapa2.update(mata: mata_away += 1)
        end

      redirect_to staff_zone_group_team_schedule_match_report_path(id:@staff_match_report), notice: "Disimpan."
    else
      render 'new'
    end
  end

  def edit
    @group = Staff::Group.find params[:group_id]
    @staff_team_schedule = Staff::TeamSchedule.find params[:team_schedule_id]
    @staff_match_report = Staff::MatchReport.find params[:id]
    if @staff_match_report
      render
    else
      redirect_to staff_zone_group_team_schedule_match_report_path(id:@staff_match_report), notice: "Maaf! Keputusan perlawanan tidak dijumpai!"
    end
  end

  def update
    @group = Staff::Group.find params[:group_id]
    @staff_team_schedule = Staff::TeamSchedule.find params[:team_schedule_id]
    @staff_match_report = Staff::MatchReport.find params[:id]
    ###############################################

    @siapa1 = Staff::GroupTeam.find_by_team_id (@staff_team_schedule.home_team_id)
    @siapa2 = Staff::GroupTeam.find_by_team_id (@staff_team_schedule.away_team_id)

      current_home_gm = @siapa1.gol_masuk
      current_home_gb = @siapa1.gol_bolos
      current_away_gm = @siapa2.gol_masuk
      current_away_gb = @siapa2.gol_bolos
      perlawanan_home = @siapa1.perlawanan
      perlawanan_away = @siapa2.perlawanan
      menang_home = @siapa1.menang
      menang_away = @siapa2.menang
      kalah_home = @siapa1.kalah
      kalah_away = @siapa2.kalah
      seri_home = @siapa1.seri
      seri_away = @siapa2.seri
      mata_home = @siapa1.mata
      mata_away = @siapa2.mata

      rm = @staff_match_report
      sm = rm.staff_team_schedule.home_team_id = @siapa1.team_id
      tm = Staff::MatchReport.joins(:staff_team_schedule).where("home_team_id = ?", sm)
      gm = tm.last.score_home_team

      rb = @staff_match_report
      sb = rb.staff_team_schedule.home_team_id = @siapa1.team_id
      tb = Staff::MatchReport.joins(:staff_team_schedule).where("home_team_id = ?", sb)
      gb = tb.last.score_away_team

      # keputusan asal home = 2
      # edit keputusan home = 3
      # current_home_gm = 3
      # current_home_gb = 2

      # keputusan asal away = 3
      # edit keputusan away = 4
      # current_away_gm = 3
      # current_away_gb = 2

      # 3 > 2 home
      if staff_match_report_params[:score_home_team].to_i > @staff_match_report.score_home_team_was
        scgm = staff_match_report_params[:score_home_team].to_i - @staff_match_report.score_home_team_was

        @siapa1.update(gol_masuk: current_home_gm += scgm)
        @siapa2.update(gol_bolos: current_away_gb += scgm)
      end
      # 3 < 2 home
      if staff_match_report_params[:score_home_team].to_i < @staff_match_report.score_home_team_was
        scgm = @staff_match_report.score_home_team_was - staff_match_report_params[:score_home_team].to_i

        @siapa1.update(gol_masuk: current_home_gm -= scgm)
        @siapa2.update(gol_bolos: current_away_gb -= scgm)
      end

      if staff_match_report_params[:score_away_team].to_i > @staff_match_report.score_away_team_was
        scgm = staff_match_report_params[:score_away_team].to_i - @staff_match_report.score_away_team_was

        @siapa2.update(gol_masuk: current_away_gm += scgm)
        @siapa1.update(gol_bolos: current_home_gb += scgm)
      end
      # 3 < 2 home
      if staff_match_report_params[:score_away_team].to_i < @staff_match_report.score_away_team_was
        scgm = @staff_match_report.score_away_team_was - staff_match_report_params[:score_away_team].to_i

        @siapa2.update(gol_masuk: current_away_gm -= scgm)
        @siapa1.update(gol_bolos: current_home_gb -= scgm)
      end

      #############################
      if @staff_match_report.update_attributes staff_match_report_params
        redirect_to staff_zone_group_team_schedule_match_report_path(id:@staff_match_report), notice: "Keputusan perlawanan berjaya dikemaskini."
      else
        render 'edit'
      end
  end

  private

    def staff_match_report_params
      params.require(:staff_match_report).permit(:team_schedule_id, :best_player_id, :cuaca, :jumlah_penonton, :pengadil, :catatan, :score_home_team, :score_away_team, staff_game_statistics_attributes: [
        :id, :kod_id, :staff_match_report_id, :team_player_id, :team_id, :minute, :count
        ])
    end
end
