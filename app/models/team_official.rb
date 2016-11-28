class TeamOfficial < ActiveRecord::Base
  mount_uploader :profile_picture, PlayerPictureUploader
  mount_uploader :salinan_sijil, PlayerPictureUploader

  after_create :random_ref_id

  belongs_to :team

  POSITION_OPTIONS = [
    "Pengurus", "Penolong Pengurus", "Penolong Pengurus 2", "Ketua Jurulatih", "Penolong Ketua Jurulatih 2",
    "Jurulatih Penjaga Gawang", "Jurulatih Penjaga Gawang 2", "General Coordinator", "Pengerusi", "Setiausaha",
    "Penolong Setiusaha", "Setiausaha Kehormat", "Bendahari" "Penolong Bendahari", "Pegawai Tadbir", "Penolong Pegawai Tadbir",
    "Fisioterapi", "Penolong Fisioterapi", "Kitman", "Penolong Kitman", "Jurulatih", "Penolong Jurulatih", "Jurulatih Kecergasan",
    "Penolong Jurulatih Kecergasan", "Pegawai Media", "Penolong Pegawai Media", "Pegawai Perubatan", "Penolong Pegawai Perubatan",
    "Pegawai ICT", "Penolong Pegawai ICT", "Pegawai Khas", "Penolong Pegawai Khas", "Pegawai Pasukan", "Penolong Pegawai Pasukan",
    "Pegawai Pengiring", "Penolong Pegawai Pengiring", "Pegawai Penyelaras", "Penolong Pegawai Penyelaras", "Pegawai Peralatan",
    "Penolong Pegawai Peralatan", "Pegawai Perhubungan", "Penolong Pegawai Perhubungan", "Pegawai Teknikal", "Penolong Pegawai Teknikal",
    "Pegawai Tempat", "Penolong Pegawai Tempat", "Penaung", "Pengarah Teknikal", "Tugas Khas", "Pengawai Keselamatan", "Penolong Pegawai Keselamatan",
    "Pemandu", "Penolong Pemandu"
  ]

  validates_presence_of :name
  validates_presence_of :position
  validates_presence_of :salinan_sijil, :if => lambda { |o| o.position == "Ketua Jurulatih" }
  validates_presence_of :no_sijil, :if => lambda { |o| o.position == "Ketua Jurulatih" }
  validates_uniqueness_of :ic_number
  validates :ic_number, numericality: { only_integer: true }, length: { maximum: 12 }, format: { without: /\s/ }
  validates :phone_number, numericality: { only_integer: true }, format: { without: /\s/ }, allow_blank: true

  default_scope -> { order('team_officials.created_at DESC') }
  scope :by_state, -> (state_id) { joins(:team).where('teams.state_id = ?', state_id) }

  def random_ref_id
    random = ['1'..'9'].map { |i| i.to_a }.flatten
    player_ref_id = (0...6).map { random[rand(random.length)] }.join
    self.update_attributes(ref_id: "LBR" + player_ref_id)
  end
end
