class LoTeamOfficialPdf < Prawn::Document
  require 'prawn/table'
  require 'open-uri'

  def initialize(team_officials, team, view)
    super()
    @team_officials = team_officials
    @team = team
    @view = view
    lbr
    logo
    team_details
  end

  def lbr
    move_up 10
    logopath =  "#{Rails.root}/app/assets/images/LogoLBR.png"
    image logopath, :width => 80, :height => 80, :position => :center
    move_down 5
    text "LIGA BOLA SEPAK RAKYAT", :size => 14, :color => "585858", :style => :bold, :align => :center
    text "E-2-08, 2nd Floor, Capital 5, Oasis Square, Jalan PJU 1A/7A, Oasis Damansara", :size => 8, :color => "585858", :align => :center
    text "47301 Petaling Jaya,  Selangor Darul Ehsan", :size => 8, :color => "585858", :align => :center
    text "Web: http://lbr.org.my", :size => 8, :color => "585858", :align => :center
    move_down 5
    text "----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------", :size => 8, :color => "c1c1c1", :align => :center
    move_down 10
  end

  def logo
    text "#{@team.team_name.upcase}", :size => 20, :color => "585858", :style => :bold
    move_up 28

    data = [
      [nil,nil,nil,"ID Pasukan", "#{@team.team_ref_id}"],
      [nil,nil,nil,"Negeri", "#{@team.state.name}"]
    ]

    table(data, :cell_style => {:size => 8, :text_color => "585858"}, :width => 540) do
      cells.padding = 1
      cells.border_width = 0
      row(0..4).columns(0..2).borders = [:left]
      columns(0..2).borders = []
      row(0..4).columns(3).font_style = :bold
      columns(3..4).width = 85
    end

    move_down 1
    text "#{@team.address}", :size => 7, :color => "585858"
    text "No Telefon: #{@team.phone_number}", :size => 7, :color => "585858"
    text "Alamat Emel: #{@team.team_email_address}", :size => 7, :color => "585858"
  end

  def team_details
    move_down 20
    text "Senarai Pegawai Pasukan", :size => 11, :color => "585858"
    move_down 4
    data = [
      ["No", "ID", "Nama Pegawai", "No Kad Pengenalan", "Posisi", "No Telefon"]
    ]
    @team_officials.each_with_index do |f, index|
      data += [
        ["#{index + 1}", "#{f.ref_id}", "#{f.name}", "#{f.ic_number}", "#{f.position}", "#{f.phone_number}"]
      ]
    end

    table(data, :header => true, :cell_style => {:size => 8, :text_color => "585858"}, :width => 540) do
      cells.padding = 8
      cells.border_width = 0.5
      row(0).font_style = :bold
      row(1..100).columns(0..4).borders = [:bottom, :left, :right]
      columns(0).width = 27
      columns(1).width = 60
      columns(3..5).width = 75
    end
  end
end
