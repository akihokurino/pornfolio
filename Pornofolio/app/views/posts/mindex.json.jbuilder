json.posts do |json|
  json.array!(@posts) do |post|
    json.post_id  post[:id]
    json.title    post[:title]
    json.thumb    post[:thumbnail]
    json.desc     post[:description]
    json.type     post[:post_type_id]
    json.like_count post[:like_count]
    json.user do |json|
      json.id   post[:user_id]
      json.name @post_user[post[:user_id]]
    end
    json.tag do |json|
      json.array!(post.tags) do |tag|
        json.extract! tag, :id, :name
      end
    end
    json.category post.categories.first, :id, :name
  end
end

json.post_count @count

#json.tags do |json|
#  json.array!(@tags) do |tag|
#    json.extract! tag, :id, :name
#  end
#end

json.categories do |json|
  json.array!(@categories) do |category|
    json.extract! category, :id, :name
  end
end

json.ranking do |json|
  json.array!(@ranking_posts) do |post|
    json.post_id  post[:id]
    json.title    post[:title]
    json.thumb    post[:thumbnail]
    json.desc     post[:description]
    json.type     post[:post_type_id]
    json.like_count post[:like_count]
    json.user do |json|
      json.id   post[:user_id]
      json.name @ranking_user[post[:user_id]]
    end
    json.tag do |json|
      json.array!(post.tags) do |tag|
        json.extract! tag, :id, :name
      end
    end
    json.category post.categories.first, :id, :name
  end
end