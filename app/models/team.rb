class Team < ActiveRecord::Base
  enum status: [:pending, :registered, :rejected]
  after_create :random_team_ref_id
  mount_uploader :team_logo, TeamLogoUploader
  mount_uploader :team_image, TeamLogoUploader

  belongs_to :state
  belongs_to :user
  belongs_to :admin_officer, class_name: "User", foreign_key: "admin_officer_id"
  belongs_to :general_coordinator, class_name: "User", foreign_key: "general_coordinator_id"
  has_many :team_officials, as: :teamoffable, dependent: :destroy

  accepts_nested_attributes_for :team_officials, allow_destroy: true

  default_scope -> { order('teams.created_at DESC') }
  scope :pending, -> { where ('status = 0')}
  scope :by_state, -> (state_id) { where(state_id: state_id) }

  def random_team_ref_id
    random = ['1'..'9'].map { |i| i.to_a }.flatten
    team_ref_id = (0...7).map { random[rand(random.length)] }.join
    self.update_attributes(team_ref_id: "MY" + team_ref_id)
  end
end
