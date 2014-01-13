json.array!(@rules) do |rule|
  json.extract! rule, :id, :description
  json.url rule_url(rule, format: :json)
end
