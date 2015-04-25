# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'securerandom'

#users = User.create([{email: 'email1@gmail.com', password: 'derp1234', zip_code: '12345', uses_electricity: true, uses_water: true, uses_natural_gas: true},
#			 {email: 'email2@gmail.com', password: 'derp1235', zip_code: '12345', uses_electricity: true, uses_water: true, uses_natural_gas: true},
#			 {email: 'email3@gmail.com', password: 'derp1236', zip_code: '12345', uses_electricity: true, uses_water: true, uses_natural_gas: true}])

users = User.find([14,15,16])

months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec']

users.each do |x|
	(0..11).each do |y|
		x.stats << Stat.create(year: 2014, month: y, water_usage: (5000 + rand(17000)), electricity_usage: (500 + rand(1000)), natural_gas_usage: (30 + rand(170)))
	end
	x.save
end	
