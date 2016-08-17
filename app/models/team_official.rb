class TeamOfficial < ActiveRecord::Base
  belongs_to :teamable, polymorphic: true
end
