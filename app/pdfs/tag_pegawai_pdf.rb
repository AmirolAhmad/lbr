class TagPegawaiPdf < Prawn::Document
  require 'prawn/table'
  require 'open-uri'

  def initialize(team_official, view)
    super(:page_size => "A5", :background => "#{Rails.root}/app/assets/images/tag_pegawai.jpg")
    @team_official = team_official
    @view = view
    details
  end

  def details
    defaultimage =  "#{Rails.root}/app/assets/images/default-avatar.png"
    userimage = "#{@team_official.profile_picture_url}"
    image open("#{@team_official.profile_picture? ? userimage : defaultimage}"), width: 133, height: 171, at: [-30, 481]

    draw_text "#{@team_official.name.upcase}", at: [45, 284], :size => 18, :style => :bold
    draw_text "#{@team_official.position.upcase}", at: [75, 239], :size => 18, :style => :bold
    draw_text "#{@team_official.team.team_name.upcase}", at: [75, 202], :size => 18, :style => :bold
    draw_text "#{@team_official.ic_number.upcase}", at: [175, 159], :size => 18, :style => :bold
    draw_text "#{@team_official.ref_id}", at: [75, 118], :size => 18, :style => :bold
  end
end
