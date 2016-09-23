class TeamOfficial < ActiveRecord::Base
  mount_uploader :profile_picture, PlayerPictureUploader
  mount_uploader :salinan_sijil, PlayerPictureUploader

  after_create :random_ref_id

  belongs_to :team

  validates_presence_of :salinan_sijil, :if => lambda { |o| o.position == "Ketua Jurulatih" }
  validates_presence_of :no_sijil, :if => lambda { |o| o.position == "Ketua Jurulatih" }
  validates_uniqueness_of :ic_number
  validates :ic_number, numericality: { only_integer: true }, length: { maximum: 12 }

  default_scope -> { order('team_officials.created_at DESC') }

  def random_ref_id
    random = ['1'..'9'].map { |i| i.to_a }.flatten
    player_ref_id = (0...6).map { random[rand(random.length)] }.join
    self.update_attributes(ref_id: "LBR" + player_ref_id)
  end
end
