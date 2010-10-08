class Friend < ActiveRecord::Base
  belongs_to :user
  belongs_to :fuser, :class_name => 'User'
end