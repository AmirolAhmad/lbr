class TeamPlayer < ActiveRecord::Base
  mount_uploader :player_picture, PlayerPictureUploader
  mount_uploader :ic_picture, PlayerPictureUploader

  after_create :random_player_ref_id

  belongs_to :team

  validates_uniqueness_of :ic_number

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
end
