class StateTeamOfficialPdf < Prawn::Document
  require 'prawn/table'
  require 'open-uri'

  def initialize(team_officials, view)
    super()
    @team_officials = team_officials
    @view = view
    lbr
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

  def team_details
    move_down 20
    text "Senarai Pegawai", :size => 11, :color => "585858"
    move_down 4
    data = [
      ["No", "Pasukan", "ID", "", "Nama Pegawai", "No Kad Pengenalan", "Posisi"]
    ]
    @team_officials.each_with_index do |f, index|
      userimage = "#{f.profile_picture_url(:standar)}"
      defaultimage =  "#{Rails.root}/app/assets/images/default-avatar.png"
      player_image = open("#{f.profile_picture? ? userimage : defaultimage}")
      data += [
        ["#{index + 1}", "#{f.team.team_name}", "#{f.ref_id}", {image: player_image, image_height: 13}, "#{f.name}", "#{f.ic_number}", "#{f.position}"]
      ]
    end

    table(data, :header => true, :cell_style => {:size => 8, :text_color => "585858"}, :width => 540) do
      cells.padding = 8
      cells.border_width = 0.5
      row(0).font_style = :bold
      columns(0).width = 27
      columns(1).width = 60
      columns(2).width = 60
      columns(3).width = 28
      columns(5..6).width = 75
      columns(7).width = 40
    end
  end
end
