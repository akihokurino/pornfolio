json.side do |json|
  json.array! @side_ad, :id, :ad_object
end

json.footer do |json|
  json.array! @footer_ad, :id, :ad_object
end