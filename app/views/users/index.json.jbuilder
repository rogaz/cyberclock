json.array!(@users) do |user|
  json.extract! user, :id, :name, :address, :phone
  json.url user_url(user, format: :json)
end
