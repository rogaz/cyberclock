json.array!(@products) do |product|
  json.extract! product, :id, :description
  json.url product_url(product, format: :json)
end
