class Team < ActiveRecord::Base
  enum status: [:pending, :registered, :rejected]
  after_create :random_team_ref_id

  belongs_to :user
  belongs_to :state

  default_scope -> { order('teams.created_at DESC') }
  scope :pending, -> { where ('status = 0')}
  scope :by_state, -> (state_id) { where(state_id: state_id) }

  def random_team_ref_id
    random = ['1'..'9'].map { |i| i.to_a }.flatten
    team_ref_id = (0...7).map { random[rand(random.length)] }.join
    self.update_attributes(team_ref_id: "MY" + team_ref_id)
  end
end
