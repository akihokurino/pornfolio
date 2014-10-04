json.tags do |json|
  json.array!(@tags) do |tag|
    json.extract! tag, :id, :name
  end
end

json.categories do |json|
  json.array!(@categories) do |category|
    json.extract! category, :id, :name
  end
end