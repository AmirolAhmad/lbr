class Staff::GroupTeam < ActiveRecord::Base
  belongs_to :team
  belongs_to :staff_group, class_name: 'Staff::Group'
end
