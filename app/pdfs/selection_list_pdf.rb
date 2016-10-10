class SelectionListPdf < Prawn::Document
  require 'prawn/table'

  def initialize(team, view)
    super()
    @staff_team_schedule = team
    @view = view
    lbr
    general
    list
    team_details
  end

  def lbr
    move_up 30
    logopath =  "#{Rails.root}/app/assets/images/LogoLBR.png"
    image logopath, :width => 50, :height => 50, :position => :center
    move_down 5
    text "LIGA BOLA SEPAK RAKYAT", :size => 10, :color => "585858", :style => :bold, :align => :center
    text "E-2-08, 2nd Floor, Capital 5, Oasis Square, Jalan PJU 1A/7A, Oasis Damansara", :size => 8, :color => "585858", :align => :center
    text "47301 Petaling Jaya,  Selangor Darul Ehsan", :size => 8, :color => "585858", :align => :center
    text "Web: http://lbr.org.my", :size => 8, :color => "585858", :align => :center
    move_down 1
    text "----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------", :size => 8, :color => "c1c1c1", :align => :center
  end

  def general
    text "SENARAI PILIHAN", :size => 8, :color => "585858", :style => :bold, align: :center
    move_down 5

    data = [
      ["PERLAWANAN"]
    ]
    data2 = [
      ["Bil Perlawanan", "#{@staff_team_schedule.bil_per}", "Cuaca", ""],
      ["Tarikh Perlawanan", "#{@staff_team_schedule.tarikh_perl.strftime("%d %B %Y")}", "Masa", "#{@staff_team_schedule.masa_perl.strftime("%I:%M %p")}"]
    ]
    data3 = [
      ["Venue", "#{@staff_team_schedule.venue}"]
    ]
    data4 = [
      ["#{@staff_team_schedule.home_team.team_name.upcase}", "vs", "#{@staff_team_schedule.away_team.team_name.upcase}"]
    ]
    data5 = [
      ["Senarai Pasukan PTR", "Senarai Pasukan PL"]
    ]

    table(data, :header => true, :cell_style => {:size => 8, :text_color => "585858", align: :center}, :width => 540) do
      row(0).font_style = :bold
      cells.padding = 0
      cells.height = 12
    end

    table(data2, :header => true, :cell_style => {:size => 8, :text_color => "585858", align: :left}, :width => 540) do
      cells.border_width = 0.5
      columns(0).width = 100
      columns(1).width = 180
      columns(2).width = 60
      cells.padding = 0
      cells.padding_left = 5
      cells.height = 12
    end

    table(data3, :header => true, :cell_style => {:size => 8, :text_color => "585858", align: :left}, :width => 540) do
      cells.border_width = 0.5
      columns(0).width = 100
      cells.padding = 0
      cells.padding_left = 5
      cells.height = 12
    end

    table(data4, :header => true, :cell_style => {:size => 8, :text_color => "585858", align: :center}, :width => 540) do
      row(0).font_style = :bold
      columns(1).width = 30
      cells.padding = 0
      cells.height = 12
    end

    table(data5, :header => true, :cell_style => {:size => 8, :text_color => "585858", align: :center}, :width => 540) do
      row(0).font_style = :bold
      cells.border_width = 0.5
      cells.padding = 0
      cells.height = 12
    end
  end

  def list
    data = [
      ["Bil", "M", "S", "No Jersi", "Nama Pemain", "M", "S", "No Jersi", "Nama Pemain"]
    ]
    0.upto(29) do |i|
      data += [
        ["#{i+1}", "", "", "", "", "", "", "", ""]
      ]
    end

    table(data, :header => true, :cell_style => {:size => 8, :text_color => "585858", align: :center}, :width => 540) do
      cells.padding = 0
      cells.height = 12
      cells.border_width = 0.5
      columns(0..2).width = 27
      columns(3).width = 35
      columns(4).width = 156
      columns(5..6).width = 27
      columns(7).width = 35
    end
  end

  def team_details
    data = [
      ["Pemain Digantung Pasukan PTR", "Pemain Digantung Pasukan PL"]
    ]

    data2 = [
      ["No Jersi", "Nama Pemain", "No Jersi", "Nama Pemain"]
    ]

    data3 = [
      ["Ketua Jurulatih", "Pengurus Pasukan", "Ketua Jurulatih", "Pengurus Pasukan"]
    ]

    data4 = [
      ["Pegawai Pertandingan"]
    ]

    data5 = [
      ["Pengadil", "", "Pegawai Ke-4", ""],
      ["Pen. Pengadil 1", "", "Gen. Coordinator", ""],
      ["Pen. Pengadil 2", "", "Komisioner Perl", ""]
    ]

    table(data, :header => true, :cell_style => {:size => 8, :text_color => "585858", align: :center}, :width => 540) do
      row(0).font_style = :bold
      cells.border_width = 0.5
      cells.padding = 0
      cells.height = 12
    end

    0.upto(1) do |i|
      data2 += [
        ["", "", "", ""]
      ]
    end

    table(data2, :header => true, :cell_style => {:size => 8, :text_color => "585858", align: :center}, :width => 540) do
      cells.padding = 0
      cells.height = 12
      cells.border_width = 0.5
      columns(0).width = 40
      columns(2).width = 40
      columns(1).width = 232
    end

    0.upto(0) do |i|
      data3 += [
        # @team_officials.select('distinct name').collect { |p| p.name }
        #["#{@team_officials.where(position: "Ketua Jurulatih").collect { |p| p.name }.join(', ')}", "", "", ""],
        ["T.T", "T.T", "T.T", "T.T"]
      ]
    end

    table(data3, :header => true, :cell_style => {:size => 8, :text_color => "585858", align: :center}, :width => 540) do
      row(0).font_style = :bold
      cells.padding = 0
      cells.height = 12
      cells.border_width = 0.5
      columns(1).width = 144
      row(2).padding_left = 5
      row(2).align = :left
      row(2).height = 35
    end

    table(data4, :header => true, :cell_style => {:size => 8, :text_color => "585858", align: :center}, :width => 540) do
      row(0).font_style = :bold
      cells.padding = 0
      cells.height = 12
    end

    table(data5, :header => true, :cell_style => {:size => 8, :text_color => "585858", align: :left}, :width => 540) do
      cells.border_width = 0.5
      columns(0).width = 90
      columns(1).width = 180
      columns(2).width = 90
      cells.padding = 0
      cells.padding_left = 5
      cells.height = 12
    end

    move_down 5
    text "M = Main (11 orang), S = Simpanan (7 orang), Lain-lain = Tidak disenarai", :size => 8, :color => "585858", align: :center
    move_down 40
    text "Tandatangan Komissioner Perlawanan/Koordinator Perlawanan: ___________________________________________", :size => 8, :color => "585858", align: :center

  end
end
