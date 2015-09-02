class User < ActiveRecord::Base
  has_many :stats, -> { order 'year ASC, month ASC' }
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	def last_twelve_months
		stats.last(12).as_json(:methods => [:carbon_footprint])
	end

	# Be sure to update Stat model too!
	def carbon_footprint
		lbs_to_kg = 0.453592
		electricity_factor = 1.46 * lbs_to_kg
		gallons_to_liters = 3.78541
		water_factor = 0.001 * gallons_to_liters
		natural_gas_factor = 5.0
		footprint = self.electricity_usage * electricity_factor + self.water_usage * water_factor + self.natural_gas_usage + natural_gas_factor
		footprint.round(3)
	end

	def carbon_ranking
		users = User.where("zip_code = ?", self.zip_code)
		usages = []
		users.each do |x|
			usages << x.carbon_footprint.to_f
		end
		sorted = usages.sort

		count = 0
		c = self.carbon_footprint

		less_than = (sorted.index(c) == nil) ? 0 : sorted.index(c)

		sorted.each do |x|
			if x == c
				count += 1
			end
		end

		percentile = (less_than + (count*0.5))/sorted.length
		avg = usages.inject(0, :+) / sorted.count
		{percentile: percentile, average: avg.round(3), your_average: c.to_f}
	end

	def electricity_ranking
		users = User.where("zip_code = ?", self.zip_code)
		usages = []
		users.each do |x|
			usages << x.electricity_usage.to_f
		end
		sorted = usages.sort

		count = 0
		elec = self.electricity_usage

		less_than = (sorted.index(elec) == nil) ? 0 : sorted.index(elec)

		sorted.each do |x|
			if x == elec
				count += 1
			end
		end

		percentile = (less_than + (count*0.5))/sorted.length
		avg = usages.inject(0, :+) / sorted.count
		{percentile: percentile, average: avg.round(3), your_average: elec.to_f}
	end

	def water_ranking
		users = User.where("zip_code = ?", self.zip_code)
		usages = []
		users.each do |x|
			usages << x.water_usage.to_f
		end
		sorted = usages.sort

		count = 0
		elec = self.water_usage

		less_than = (sorted.index(elec) == nil) ? 0 : sorted.index(elec)

		sorted.each do |x|
			if x == elec
				count += 1
			end
		end

		percentile = (less_than + (count*0.5))/sorted.length
		avg = usages.inject(0, :+) / sorted.count
		{percentile: percentile, average: avg.round(3), your_average: elec.to_f}
	end

	def natural_gas_ranking
		users = User.where("zip_code = ?", self.zip_code)
		usages = []
		users.each do |x|
			usages << x.natural_gas_usage.to_f
		end
		sorted = usages.sort

		count = 0
		elec = self.natural_gas_usage

		less_than = (sorted.index(elec) == nil) ? 0 : sorted.index(elec)

		sorted.each do |x|
			if x == elec
				count += 1
			end
		end

		percentile = (less_than + (count*0.5))/sorted.length
		avg = usages.inject(0, :+) / sorted.count
		{percentile: percentile, average: avg.round(3), your_average: elec.to_f}
	end

	def electricity_usage
		#Stat.where(user: self).average(:electricity_usage)
		self.stats.average(:electricity_usage).round(3) rescue 0.0
	end

	def water_usage
		self.stats.average(:water_usage).round(3) rescue 0.0
	end

	def natural_gas_usage
		self.stats.average(:natural_gas_usage).round(3) rescue 0.0
	end
end
