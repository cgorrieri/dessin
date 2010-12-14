class Information < ActiveRecord::Base
  set_table_name 'informations'

  belongs_to :writer, :class_name => "User"
end
