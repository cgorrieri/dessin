# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

User.create(:role => '100', :birth_date => "1991-10-20", :pseudo => "Cyril", :email => "admin@cyart.com", :password => "hunter/15", :password_confirmation => "hunter/15")