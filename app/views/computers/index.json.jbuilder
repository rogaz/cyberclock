json.array!(@computers) do |computer|
  json.extract! computer, :id, :name, :branch_id
  json.url computer_url(computer, format: :json)
end
