class TagPemainPdf < Prawn::Document
  require 'prawn/table'
  require 'open-uri'

  def initialize(team_player, view)
    super(:page_size => "A6", :background => "#{Rails.root}/app/assets/images/tag_pemain.jpg")
    @team_player = team_player
    @view = view
    details
  end

  def details
    defaultimage =  "#{Rails.root}/app/assets/images/default-avatar.png"
    userimage = "#{@team_player.player_picture_url}"
    image open("#{@team_player.player_picture? ? userimage : defaultimage}"), width: 95, height: 118, at: [-32, 325]

    draw_text "#{@team_player.player_name.upcase}", at: [-25, 161], :size => 10, :style => :bold
    draw_text "#{@team_player.team.team_name.upcase}", at: [-25, 127], :size => 10, :style => :bold
    draw_text "#{@team_player.jersey_no}", at: [200, 120], :size => 51, :style => :bold
    draw_text "#{@team_player.ic_number.upcase}", at: [-25, 96], :size => 10, :style => :bold
    draw_text "#{@team_player.ref_id}", at: [-25, 65], :size => 10, :style => :bold
  end
end
