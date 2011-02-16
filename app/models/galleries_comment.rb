class GalleriesComment < ActiveRecord::Base
  belongs_to :from_user, :class_name => "User"
  belongs_to :to_gallery, :class_name => "Gallery"

  scope :unsee, where("see <> 1")
end
