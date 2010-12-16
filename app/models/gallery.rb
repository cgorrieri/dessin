class Gallery < ActiveRecord::Base
  belongs_to :user
  has_many :drawings, :as => :media_container, :class_name => 'Media', :dependent => :destroy

  validates :name, :presence => true
  validates :keywords, :presence => true

  @@per_page = 10
  
end
