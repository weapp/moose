# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

['unapproved', 'read-only', 'read-one-write-one', 'read-all-write-one', 'admin'].each do |role|
  Role.find_or_create_by_name role
end

u = User.create({username: 'admin', email: 'admin@moose.com', password: 'qweasd'})

u.role = Role.find_by_name('admin')
u.save