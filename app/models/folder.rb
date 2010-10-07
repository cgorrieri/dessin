class Folder < ActiveRecord::Base
  belongs_to :user
  
  has_many :drawings, :as => :media_container, :class_name => 'Media'

  validates :name, :presence => true

  @@per_page = 10
  
end
