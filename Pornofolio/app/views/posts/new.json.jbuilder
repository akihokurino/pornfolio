json.category do |json|
  json.array!(@category) do |category|
    json.extract! category, :id, :name
  end
end
json.post_type    @post_type
json.content_type @post_content_type
json.detail_type  @post_content_detail_type
json.user_name    @user_name