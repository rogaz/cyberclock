json.array!(@rents) do |rent|
  json.extract! rent, :id, :name, :duration, :rent_type, :computer_id
  json.url rent_url(rent, format: :json)
end
