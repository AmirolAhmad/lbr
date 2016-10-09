class Staff::Group < ActiveRecord::Base
  belongs_to :staff_zone, class_name: 'Staff::Zone'
end
