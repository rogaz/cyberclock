json.array!(@branches) do |branch|
  json.extract! branch, :id, :name, :company_id
  json.url branch_url(branch, format: :json)
end
