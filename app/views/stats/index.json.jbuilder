json.array!(@stats) do |stat|
  json.extract! stat, :id, :id, :user_id, :electricity_usage, :water_usage, :natural_gas_usage, :month, :year
  json.url stat_url(stat, format: :json)
end
