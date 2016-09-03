class TeamConfig < ActiveRecord::Base
  belongs_to :state
  belongs_to :teamable, polymorphic: true
  belongs_to :user
end
