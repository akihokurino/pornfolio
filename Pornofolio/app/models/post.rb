class Post < ActiveRecord::Base
  include Redis::Objects
  belongs_to :user
  belongs_to :post_types

  has_many :posts_tags, :dependent => :destroy
  has_many :tags, :through => :posts_tags
  has_many :categories_posts, :dependent => :destroy
  has_many :categories, :through => :categories_posts
  has_many :post_contents, :dependent => :destroy
  has_many :post_analyses
  has_many :post_comments, :dependent => :destroy
  has_many :post_content_details, :through => :post_contents, :dependent => :destroy
  has_many :post_likes, :dependent => :destroy
  has_many :access_logs
  has_many :user_favorites

  value :ranking, global: true

  validates :title, length: { maximum: 255 }, :presence => true
  validates :description, length:  { maximum: 255 }
  validate :pt_exist?

  attr_accessor :favorited
  attr_accessor :liked


  class << self
    # 投稿関連のデータを作成
    def relation_create(user_id, params)
      transaction do
        User.find(user_id).update(name: params[:user_name]) if params[:user_name].present?
        @post = create!(
            :user_id      => user_id,
            :title        => params[:title],
            :thumbnail    => params[:thumb],
            :description  => params[:desc],
            :post_type_id => params[:post_type]
        )
        save_tags(@post[:id], params[:tags])
        CategoriesPost.create!(
            :category_id => params[:category],
            :post_id     => @post[:id]
        )
        raise ActiveRecord::Rollback unless save_contents(@post[:id], params[:contents])
      end
    end


    def m_category_relation_find(id, type, partition, category_id)
      category = Category.find(category_id).posts
      count    = category.count(:id)
      table    = self.arel_table
      post     = if type == "oldest"
                   if id == 0
                     category.order(:id => :desc).limit(partition)
                   else
                     category.where(table[:id].lt(id)).order(:id => :desc).limit(partition)
                   end
                 elsif type == "newest"
                   category.where(table[:id].gt(id)).limit(partition)
                 end
      user = Hash[*User.where(id: post.pluck(:user_id)).pluck(:id, :name).flatten]
      {post: post.includes(:categories, :tags), user: user, count: count}
    end

    def m_tag_relation_find(id, type, partition, tag_id)
      tag    = Tag.find(tag_id).posts
      count  = tag.count(:id)
      table  = self.arel_table
      post   = if type == "oldest"
                 if id == 0
                   tag.order(:id => :desc).limit(partition)
                 else
                   tag.where(table[:id].lt(id)).order(:id => :desc).limit(partition)
                 end
               elsif type == "newest"
                 tag.where(table[:id].gt(id)).limit(partition)
               end
      user = Hash[*User.where(id: post.pluck(:user_id)).pluck(:id, :name).flatten]
      {post: post.includes(:categories, :tags), user: user, count: count}
    end

    def m_relation_find(id, type, partition)
      count = self.count(:id)
      table = self.arel_table
      post  = if type == "oldest"
                if id == 0
                  self.order(:id => :desc).limit(partition)
                else
                  self.where(table[:id].lt(id)).order(:id => :desc).limit(partition)
                end
              elsif type == "newest"
                self.where(table[:id].gt(id)).limit(partition)
              end
      user = Hash[*User.where(id: post.pluck(:user_id)).pluck(:id, :name).flatten]
      {post: post.includes(:categories, :tags), user: user, count: count}
    end

    def relation_find(page, partition)
      count = self.count(:id)
      post  = self.order(:created_at => :desc).page(page).per(partition)
      user  = Hash[*User.where(id: post.pluck(:user_id)).pluck(:id, :name).flatten]
      {post: post.includes(:categories, :tags), user: user, count: count}
    end

    def category_relation_find(page, partition, category_id)
      category = Category.find(category_id).posts
      count    = category.count(:id)
      post     = category.order(:created_at => :desc).page(page).per(partition)
      user     = Hash[*User.where(id: post.pluck(:user_id)).pluck(:id, :name).flatten]
      {post: post.includes(:categories, :tags), user: user, count: count}
    end

    def tag_relation_find(page, partition, tag_id)
      tag    = Tag.find(tag_id).posts
      count  = tag.count(:id)
      post   = tag.order(:created_at => :desc).page(page).per(partition)
      user   = Hash[*User.where(id: post.pluck(:user_id)).pluck(:id, :name).flatten]
      {post: post.includes(:categories, :tags), user: user, count: count}
    end

    # ランキング項目を取得する
    def find_ranking(subject = :week)
      rank                  = JSON.parse(self.ranking, {:symbolize_names => true})
      field_sanitized_query = self.send(:sanitize_sql_array, ["field(id, ?)", rank[subject]])
      post                  = self.where(id: rank[subject]).order(field_sanitized_query)
      user                  = Hash[*User.where(id: post.pluck(:user_id)).pluck(:id, :name).flatten]
      {post: post.includes(:categories, :tags), user: user}
    end


    private
    # タグを保存する際のメソッド
    def save_tags(post_id, tags)
      # tagsパラメータがない場合、処理を抜ける
      return if tags.blank?

      tag_models = []
      tags.each do |tag|
        tag_models << Tag.new(name: tag) if tag.present?
      end
      # tagsパラメータに空白や空文字しか入っていなかった場合、処理を抜ける
      return if tag_models.blank?
      tag_names = tag_models.map(&:name)
      # tagをinsertする
      Tag.import tag_models

      # posts_tags中間テーブルにinsertする
      tag_ids = Tag.where(name: tag_names).order(:id).pluck(:id)
      posts_tags_models = []
      tag_ids.each do |tag_id|
        posts_tags_models << PostsTag.new(
            :post_id => post_id,
            :tag_id  => tag_id
        )
      end
      PostsTag.import posts_tags_models
    end

    # contentsに関連するテーブルに保存していく
    def save_contents(post_id, contents)
      return false if contents.blank?

      content_models = []
      orders  = []
      pcts    = []
      details = []
      contents.each do |content|
        orders  << content[:order]
        pcts    << content[:content_type]
        details << content[:details]
        content_models << PostContent.new(
            :post_id              => post_id,
            :order                => content[:order],
            :post_content_type_id => content[:content_type]
        )
      end
      # orderがuniqueであるかの確認
      return false if (orders - orders.uniq).present?
      # 存在しないpost_content_type_idが渡されていないか確認
      return false unless pct_exist?(pcts.uniq)

      PostContent.import content_models, :validate => false
      content_ids = bulk_insert_keys(content_models.size)

      pcdt = []
      detail_models = []
      details.zip(content_ids).each do |detail, content_id|
        pcdt << detail[:detail_type]
        detail_models << PostContentDetail.new(
            :post_content_id             => content_id,
            :text                        => detail[:substance],
            :post_content_detail_type_id => detail[:detail_type]
        )
      end
      # 存在しないpost_content_detail_type_idが渡されていないか確認
      return false unless pcdt_exist?(pcdt.uniq)

      PostContentDetail.import detail_models, :validate => false
      detail_ids = bulk_insert_keys(detail_models.size)

      # videoの情報収集をバックグラウンド処理させる
      DetailVideoWorker.perform_async detail_ids
      #PostContentDetail.relation_create detail_ids
      true
    end

    # post_content_type_idの存在確認
    def pct_exist?(ids)
      PostContentType.where(id: ids).size == ids.size
    end

    # post_content_detail_type_idの存在確認
    def pcdt_exist?(ids)
      PostContentDetailType.where(id: ids).size == ids.size
    end

    # BULK INSERTされたIDを返す
    def bulk_insert_keys(insert_size)
      first_insert_id = connection.last_inserted_id(nil)
      (first_insert_id..first_insert_id+insert_size-1).to_a
    end

  end

  private
  # post_type_idの存在確認
  def pt_exist?
    errors.add(:post_types, :invalid) unless PostType.ids.include?(post_type_id)
  end

end



