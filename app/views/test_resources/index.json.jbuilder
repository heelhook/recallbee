json.array!(@test_resources) do |test_resource|
  json.extract! test_resource, :id, :name
  json.url test_resource_url(test_resource, format: :json)
end
