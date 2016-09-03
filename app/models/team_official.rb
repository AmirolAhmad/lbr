class TeamOfficial < ActiveRecord::Base
  belongs_to :teamoffable, polymorphic: true
end
