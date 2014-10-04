json.posts do |json|
  json.array!(@favorites) do |favorite|
    json.post_id  favorite.post[:id]
    json.title    favorite.post[:title]
    json.thumb    favorite.post[:thumbnail]
    json.desc     favorite.post[:description]
    json.type     favorite.post[:post_type_id]
    json.category favorite.post.categories.first, :id, :name
    json.like_count favorite.post[:like_count]
    json.user do |json|
      json.id   favorite.post[:user_id]
      json.name @access_user[:name]
    end
  end
end

json.categories do |json|
  json.array!(@categories) do |category|
    json.extract! category, :id, :name
  end
end