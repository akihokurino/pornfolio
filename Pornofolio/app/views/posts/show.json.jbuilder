json.post do |json|
  json.id @post[:id]
  json.title @post[:title]
  json.thumb @post[:thumbnail]
  json.desc @post[:description]
  json.type @post[:post_type_id]
  json.categories @categories
  json.tags @tags
  json.user do |json|
    json.extract! @post_user, :hash_value, :name
  end
  json.comments @comments
  json.favorited @favorited
  json.liked @liked
  json.like_count @post[:like_count]
  json.view_count @post[:view_count]
  json.contents do |json|
    json.array!(@contents) do |content|
      json.id content[:id]
      json.post_id @post[:id]
      json.order content[:order]
      json.content_type_id content[:post_content_type_id]
      json.content_type content.post_content_type
      json.content_details do |json|
        json.array!(content.post_content_details) do |detail|
          json.id detail[:id]
          json.content_id detail[:post_content_id]
          json.text detail[:text]
          json.is_broken detail[:is_broken]
          json.is_request detail[:is_request]
          json.content_detail_type_id detail[:post_content_detail_type_id]
          json.detail_type detail.post_content_detail_type
        end
      end
    end
  end
end

json.posts do |json|
  json.array!(@posts) do |post|
    json.post_id  post[:id]
    json.title    post[:title]
    json.thumb    post[:thumbnail]
    json.desc     post[:description]
    json.type     post[:post_type_id]
    json.user do |json|
      json.id   post[:user_id]
      json.name @post_user[post[:user_id]]
    end
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

json.categories @all_categories