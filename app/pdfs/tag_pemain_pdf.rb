class TagPemainPdf < Prawn::Document
  require 'prawn/table'
  require 'open-uri'

  def initialize(team_player, view)
    super(:page_size => "A5", :background => "#{Rails.root}/app/assets/images/tag_pemain.jpg")
    @team_player = team_player
    @view = view
    details
  end

  def details
    defaultimage =  "#{Rails.root}/app/assets/images/default-avatar.png"
    userimage = "#{@team_player.player_picture_url}"
    image open("#{@team_player.player_picture? ? userimage : defaultimage}"), width: 133, height: 171, at: [-30, 480]

    draw_text "#{@team_player.player_name.upcase}", at: [45, 261], :size => 18, :style => :bold
    draw_text "#{@team_player.team.team_name.upcase}", at: [75, 212], :size => 18, :style => :bold
    draw_text "#{@team_player.jersey_no}", at: [285, 189], :size => 81, :style => :bold
    draw_text "#{@team_player.ic_number.upcase}", at: [175, 166], :size => 18, :style => :bold
    draw_text "#{@team_player.ref_id}", at: [75, 122], :size => 18, :style => :bold
  end
end
