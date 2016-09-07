class TeamOfficial < ActiveRecord::Base
  mount_uploader :salinan_sijil, PlayerPictureUploader

  belongs_to :team
end
