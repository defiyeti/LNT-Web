json.array!(@utility_tips) do |utility_tip|
  json.extract! utility_tip, :id, :id, :order, :text
  json.url utility_tip_url(utility_tip, format: :json)
end
