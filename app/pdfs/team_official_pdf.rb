class TeamOfficialPdf < Prawn::Document
  require 'prawn/table'

  def initialize(team_officials, view)
    super()
    @team_officials = team_officials
    @view = view
    logo
    team_details
  end

  def logo
  end

  def team_details
    move_down 20
    text "Team Officials List", :size => 12, :color => "585858", :style => :bold
    move_down 2
    data = [
      ["No", "Nama Pegawai", "Posisi", "No Kad Pengenalan", "No Telefon"]
    ]
    @team_officials.each_with_index do |f, index|
      data += [
        ["#{index + 1}", "#{f.name}", "#{f.position}", "#{f.ic_number}", "#{f.phone_number}"]
      ]
    end

    table(data, :header => true, :cell_style => {:size => 8, :text_color => "585858"}, :width => 540) do
      cells.padding = 8
      cells.border_width = 0.5
      row(0).font_style = :bold
      row(1..100).columns(0..4).borders = [:bottom, :left, :right]
      columns(0).width = 45
      columns(3..4).width = 75
      columns(2).width = 55
    end
  end
end
