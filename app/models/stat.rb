class Stat < ActiveRecord::Base
	belongs_to :user

	# Be sure to update User model too!
	def carbon_footprint
		lbs_to_kg = 0.453592
		electricity_factor = 1.46 * lbs_to_kg
		gallons_to_liters = 3.78541
		water_factor = 0.001 * gallons_to_liters
		natural_gas_factor = 5.0
		self.electricity_usage * electricity_factor + self.water_usage * water_factor + self.natural_gas_usage + natural_gas_factor
	end
end
