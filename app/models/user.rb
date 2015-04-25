class User < ActiveRecord::Base
  has_many :stats, -> { order 'year ASC, month ASC' }
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	def last_twelve_months
		stats.last(12)
	end

	def carbon_footprint
		# all the math that does carbon footprint
		150
	end

	def carbon_ranking
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

		less_than = sorted.index(elec)

		sorted.each do |x|
			if x == elec
				count += 1
			end
		end

		percentile = (less_than + (count*0.5))/sorted.length
		avg = usages.inject(0, :+) / sorted.count
		{percentile: percentile, average: avg}
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

		less_than = sorted.index(elec)

		sorted.each do |x|
			if x == elec
				count += 1
			end
		end

		percentile = (less_than + (count*0.5))/sorted.length
		avg = usages.inject(0, :+) / sorted.count
		{percentile: percentile, average: avg}
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

		less_than = sorted.index(elec)

		sorted.each do |x|
			if x == elec
				count += 1
			end
		end

		percentile = (less_than + (count*0.5))/sorted.length
		avg = usages.inject(0, :+) / sorted.count
		{percentile: percentile, average: avg}
	end

	def electricity_usage
		#Stat.where(user: self).average(:electricity_usage)
		self.stats.average(:electricity_usage)
	end

	def water_usage
		self.stats.average(:water_usage)
	end

	def natural_gas_usage
		self.stats.average(:natural_gas_usage)
	end
end
