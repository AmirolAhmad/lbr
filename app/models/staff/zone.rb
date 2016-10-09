class Staff::Zone < ActiveRecord::Base
  has_many :staff_groups, class_name: 'Staff::Group'
end
