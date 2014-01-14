json.array!(@promotions) do |promotion|
  json.extract! promotion, :id, :description, :company_id
  json.url promotion_url(promotion, format: :json)
end
