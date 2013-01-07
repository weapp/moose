# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

['registered', 'banned', 'moderator', 'admin'].each do |role|
  Role.find_or_create_by_name role
end

User.create([{username: 'admin', email: 'admin@moose.com', password: 'qweasd', role: Role.find_by_name('admin').id}])