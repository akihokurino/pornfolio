class PostsController < ApplicationController
  resource_description { resource_id @controller.try(:controller_path) || controller_path }
  include Doc::Posts

  # betaテスト用のメソッド
  # before_action :confirm_beta, only: [:new, :create]


  # GET /posts/mindex
  def mindex
    oldest_id = params[:oldest].to_i
    newest_id = params[:newest].to_i
    part      = params[:part] || 12

    require_type = "newest"
    target_id    = newest_id
    if (oldest_id > 0 && newest_id > 0) || newest_id == 0
      require_type = "oldest"
      target_id    = oldest_id
    end


    relation = if params[:category_id]
                 Post.m_category_relation_find(target_id, require_type, part, params[:category_id])
               elsif params[:tag_id]
                 Post.m_tag_relation_find(target_id, require_type, part, params[:tag_id])
               else
                 Post.m_relation_find(target_id, require_type, part)
               end

    @count       = relation[:count]
    @posts       = relation[:post]
    @post_user   = relation[:user]
    # @tags        = Tag.order(:created_at => :desc)
    @categories  = Category.all.sort

    ranking_relation = Post.find_ranking
    @ranking_posts   = ranking_relation[:post]
    @ranking_user    = ranking_relation[:user]
  end


  # GET /posts
  def index
    page       = params[:page] || 1
    part       = params[:part] || 12

    page = page.to_i
    part = part.to_i

    relation = if params[:category_id]
                 Post.category_relation_find(page, part, params[:category_id])
               elsif params[:tag_id]
                 Post.tag_relation_find(page, part, params[:tag_id])
               else
                 Post.relation_find(page, part)
               end

    @posts       = relation[:post]
    @post_user   = relation[:user]
    @count       = relation[:count]
    page_count   = (@count/part).ceil
    @next        = (page_count > page) ? page+1 : nil
    @prev        = (page > 1) ? page-1 : nil
    @tags        = Tag.order(:created_at => :desc)
    @categories  = Category.all.sort

    ranking_relation = Post.find_ranking
    @ranking_posts   = ranking_relation[:post]
    @ranking_user    = ranking_relation[:user]
  end


  # GET /posts/:id
  def show
    post_id     = params[:id]
    @post       = Post.find(post_id)
    @post_user  = User.find(@post[:user_id])
    @tags       = @post.tags
    @categories = @post.categories
    @comments   = @post.post_comments
    @contents   = @post.post_contents.order(:order => :asc).includes(:post_content_type, {:post_content_details => :post_content_detail_type})

    @favorited  = @access_user.user_favorites.find_by(post_id: @post[:id]).present?
    @liked      = @access_user.post_likes.find_by(post_id: @post[:id]).present?
    PostAnalysis.create_view(@post)
    @user_log[:post_id] = post_id

    ranking_relation = Post.find_ranking
    @ranking_posts   = ranking_relation[:post]
    @ranking_user    = ranking_relation[:user]
    @all_categories  = Category.all.sort
  end

  # GET /posts/new
  def new
    @user_name                = @access_user[:name]
    @category                 = Category.all.sort
    @post_type                = PostType.name_obj
    @post_content_type        = PostContentType.name_obj
    @post_content_detail_type = PostContentDetailType.name_obj
  end

  # POST /posts
  def create
    # 投稿関連のデータを作成
    Post.relation_create(@access_user[:id], create_params)
    @last_id = Post.last.id
  end

  # GET /posts/:id/edit
  def edit

  end

  # PATCH /posts/:id
  def update

  end

  # DELETE /posts/:id
  def destroy

  end


  # beta版の認証をしていない場合にstatus302のerrorコントローラーを呼ぶ
  def confirm_beta
    if cookies[:beta].blank? || Beta.record_nil?(@access_user[:id], cookies[:beta])
      raise BetaAuthError.new
    end
  end


  private
  def create_params
    params.require(:posts)
        .permit(:title, :thumb, :desc, :post_type, :category, :user_name, :tags, tags: [], contents: [:order, :content_type, details: [:substance ,:detail_type]])
  end
end
