# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
puts 'CREATING ROLES'
Role.create([
    { :name => 'admin' },
    { :name => 'user' },
    { :name => 'VIP' }
  ], :without_protection => true)
puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :name => 'DavidTuan', :email => 'vu.duc.tuan@framgia.com', :password => '1234567890', :password_confirmation => '1234567890'
puts 'New user created: ' << user.name
user2 = User.create! :name => 'TuanThuaSac', :email => 'tuanthuasacit@gmail.com', :password => '1234567890', :password_confirmation => '1234567890'
puts 'New user created: ' << user2.name
user.add_role :admin
user2.add_role :VIP

