class Profile < ActiveRecord::Base
  belongs_to :user

  validates :ic_number, numericality: { only_integer: true }, length: { maximum: 12 }, format: { without: /\s/ }
  validates :phone_number, numericality: { only_integer: true }, format: { without: /\s/ }
end
