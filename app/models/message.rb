class Message < ActiveRecord::Base
  belongs_to :discution
  belongs_to :user
end
