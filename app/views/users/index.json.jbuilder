json.array!(@users) do |user|
  json.extract! user, :id, :id, :username, :password, :email, :oauth, :oauth_expire_at, :zipcode
  json.url user_url(user, format: :json)
end
