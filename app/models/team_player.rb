class TeamPlayer < ActiveRecord::Base
  enum status: [:registered, :rejected, :in_review]
  mount_uploader :player_picture, PlayerPictureUploader
  mount_uploader :ic_picture, PlayerPictureUploader

  after_create :random_player_ref_id
  after_initialize :set_player_status, :if => :new_record?

  belongs_to :team

  validates_uniqueness_of :ic_number
  validates :ic_number, numericality: { only_integer: true }, length: { maximum: 12 }, format: { without: /\s/ }

  default_scope -> { order('team_players.created_at DESC') }

  def random_player_ref_id
    random = ['1'..'9'].map { |i| i.to_a }.flatten
    player_ref_id = (0...6).map { random[rand(random.length)] }.join
    self.update_attributes(ref_id: "LBR" + player_ref_id)
  end

  def age
    now = Time.now.utc.to_date
    now.year - self.dob.year - ((now.month > self.dob.month || (now.month == self.dob.month && now.day >= self.dob.day)) ? 0 : 1)
  end

  def set_player_status
    self.status ||= :registered
  end
end
