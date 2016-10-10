class Team < ActiveRecord::Base
  enum status: [:pending, :registered, :rejected]
  after_create :random_team_ref_id
  mount_uploader :team_logo, TeamLogoUploader
  mount_uploader :team_image, TeamLogoUploader

  belongs_to :user
  belongs_to :state
  has_many :team_players, as: :teamoffable, dependent: :destroy
  has_many :team_officials, as: :teamoffable, dependent: :destroy
  has_many :staff_group_teams, class_name: '::Staff::GroupTeam'

  accepts_nested_attributes_for :team_players, allow_destroy: true
  accepts_nested_attributes_for :team_officials, allow_destroy: true

  default_scope -> { order('teams.created_at DESC') }
  scope :pending, -> { where ('status = 0')}
  scope :by_state, -> (state_id) { where(state_id: state_id) }
  scope :available, -> { joins(:staff_group_teams).where('staff_group_teams.team_id IS NOT null') }

  def random_team_ref_id
    random = ['1'..'9'].map { |i| i.to_a }.flatten
    team_ref_id = (0...7).map { random[rand(random.length)] }.join
    self.update_attributes(team_ref_id: "MY" + team_ref_id)
  end
end
