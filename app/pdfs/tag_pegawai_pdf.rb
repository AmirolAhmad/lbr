class TagPegawaiPdf < Prawn::Document
  require 'prawn/table'
  require 'open-uri'

  def initialize(team_official, view)
    super(:page_size => "A6", :background => "#{Rails.root}/app/assets/images/tag_pegawai.jpg")
    @team_official = team_official
    @view = view
    details
  end

  def details
    defaultimage =  "#{Rails.root}/app/assets/images/default-avatar.png"
    userimage = "#{@team_official.profile_picture_url}"
    image open("#{@team_official.profile_picture? ? userimage : defaultimage}"), width: 95, height: 118, at: [-32, 325]

    draw_text "#{@team_official.name.upcase}", at: [-25, 180], :size => 10, :style => :bold
    draw_text "#{@team_official.position.upcase}", at: [-25, 149], :size => 10, :style => :bold
    draw_text "#{@team_official.team.team_name.upcase}", at: [-25, 123], :size => 10, :style => :bold
    draw_text "#{@team_official.ic_number.upcase}", at: [-25, 92], :size => 10, :style => :bold
    draw_text "#{@team_official.ref_id}", at: [-25, 63], :size => 10, :style => :bold
  end
end
