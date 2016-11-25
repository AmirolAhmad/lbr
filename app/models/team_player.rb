class TeamPlayer < ActiveRecord::Base
  enum status: [:registered, :rejected, :in_review]
  mount_uploader :player_picture, PlayerPictureUploader
  mount_uploader :ic_picture, PlayerPictureUploader

  after_create :random_player_ref_id
  after_initialize :set_player_status, :if => :new_record?

  belongs_to :team
  has_many :staff_match_reports, class_name: 'Staff::MatchReport'
  has_many :staff_game_statistics

  POSITION_OPTIONS = [
    "Penjaga Gol", "Penjaga Gol 1", "Penjaga Gol 2", "Centre Back", "Sweeper", "Full Back", "Wing Back (Kanan)", "Wing Back (Kiri)",
    "Centre Midfield", "Defensive Midfield", "Attacking Midfield", "Wide Midfield", "Winger (Kanan)", "Winger (Kiri)",
    "Centre Forward", "Striker"
  ]

  validates_uniqueness_of :ic_number
  validates_uniqueness_of :jersey_no, scope: :team_id
  validates_presence_of :player_name
  validates_presence_of :jersey_no
  validates_presence_of :position
  validates_presence_of :ic_picture
  validates_presence_of :dob
  validates_presence_of :ic_number
  validates :ic_number, numericality: { only_integer: true }, length: { maximum: 12 }, format: { without: /\s/ }
  validates :jersey_no, numericality: { only_integer: true }, length: { maximum: 3 }, format: { without: /\s/ }

  default_scope -> { order('team_players.created_at DESC') }

  def random_player_ref_id
    random = ['1'..'9'].map { |i| i.to_a }.flatten
    player_ref_id = (0...6).map { random[rand(random.length)] }.join
    self.update_attributes(ref_id: "LBR" + player_ref_id)
  end

  def age
    # now = Time.now.year
    now = Time.now.utc.to_date
    now.year - self.dob.year# - ((now.month > self.dob.month || (now.month == self.dob.month && now.day >= self.dob.day)) ? 0 : 1)
  end

  def set_player_status
    self.status ||= :registered
  end

  def best_player_detail
    "#{self.player_name} - #{self.team.team_name}"
  end
end
