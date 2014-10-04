module Doc::Posts
  extend Apipie::DSL::Concern

  api :GET, '/:resource_id', 'まとめ一覧を新規登録順に取得するAPI'
  formats ['json']
  error 400, 'パラメータエラー'
  error 503, 'データベースエラー'
  param :page, Integer, :required => false, :desc => <<-EOS
    一覧のページ番号<br>
    デフォルトで`1`
  EOS
  param :part, Integer, :required => false, :desc => <<-EOS
    ページを分ける数<br>
    デフォルトで`9`
  EOS
  description <<-EOS
    ## Example Params
    **GET Data (required url encode)** : `page=1&part=9`
    ### Transform get data to json
    <pre class="prettyprint">
    {
      "page": 1,
      "part": 9
    }
    </pre>
  EOS
  example <<-EOS
    {
      "content": {
        "page": {
          "next": null,
          "prev": null
        },
        "post_count": 15,
        "posts": [
          {
            "category": {
                "id": 2,
                "name": "巨乳"
            },
            "desc": "説明",
            "post_id": 23,
            "tag": [
              {
                "id": 15,
                "name": "hoge"
              },
              {
                "id": 16,
                "name": "fuga"
              }
            ],
            "thumb": "/Users/tadayuki/hoge.jpg",
            "title": "たいとる",
            "type": 1,
            "user": {
                "id": 15,
                "name": null
            }
          },
          ...
          {
            "category": {
              "id": 2,
              "name": "巨乳"
            },
            "desc": "説明",
            "post_id": 14,
            "tag": [
              {
                "id": 15,
                "name": "hoge"
              },
              {
                "id": 16,
                "name": "fuga"
              }
            ],
            "thumb": "/Users/tadayuki/hoge.jpg",
            "title": "たいとる",
            "type": 1,
            "user": {
              "id": 24,
              "name": null
            }
          }
        ]
      },
      "user_hash": "a1958bd6c6a94dc0a3af9070e3234d7b"
    }
  EOS
  def index
  end

  api :GET, '/:resource_id/new', 'まとめを作るページで呼び出すAPI'
  formats ['json']
  error 400, 'パラメータエラー'
  error 503, 'データベースエラー'
  description <<-EOS
    ## Params
    No parameters are required.
  EOS
  example <<-EOS
    {
      "content": {
        "category": [
          {
            "id": 15,
            "name": "SM・陵辱"
          },
          {
            "id": 16,
            "name": "お尻・アナル"
          },
          ...
          {
            "id": 14,
            "name": "野外・露出"
          },
          {
            "id": 17,
            "name": "顔射・ぶっかけ・口内発射"
          }
        ],
        "content_type": {
          "header": 2,
          "image": 4,
          "link": 5,
          "quotation": 3,
          "sns": 6,
          "text": 7,
          "video": 1
        },
        "detail_type": {
          "agesage": 2,
          "description": 5,
          "header": 4,
          "image": 3,
          "source": 6,
          "text": 8,
          "twitter": 7,
          "xvideos": 1
        },
        "post_type": {
          "advertisement": 2,
          "general": 1
        },
        "user_name": null
      },
      "user_hash": "a1958bd6c6a94dc0a3af9070e3234d7b"
    }
  EOS
  def new
  end


  api :POST, '/:resource_id', 'まとめをデータベースに保存する'
  formats ['json']
  error 400, 'パラメータエラー'
  error 503, 'データベースエラー'
  param :posts, Hash, :required => true, :desc => 'まとめ全体' do
    param :title, String, :required => true, :desc => 'まとめのタイトル'
    param :desc, String, :required => false, :desc => 'まとめの説明'
    param :category, Category.ids.sort, :required => true, :desc => 'まとめのカテゴリID'
    param :post_type, PostType.ids.sort, :required => true, :desc => 'まとめのタイプID'
    param :contents, Hash, :required => true, :desc => 'まとめのコンテンツ' do
      param :num, Hash, :required => true, :desc => '`contents`は配列で渡すが、実態は`数字(num)`がkeyとなってる' do
        param :order, Integer, :required => true, :desc => 'コンテンツの並び順'
        param :content_type, PostType.ids.sort, :required => true, :desc => 'コンテンツのタイプ(`post_content_type`)ID'
        param :details, Hash, :required => true, :desc => 'コンテンツの詳細' do
          param :num, Hash, :required => true, :desc => '`details`は配列で渡すが、実態は`数字(num)`がkeyとなってる' do
            param :substance, String, :required => true, :desc => '詳細の実態（テキスト）'
            param :detail_type, PostContentDetailType.ids.sort, :required => true, :desc => '詳細のタイプ(`post_content_detail_type`)ID'
          end
        end
      end
    end
    param :tags, Array, :required => true, :desc => <<-EOS
      まとめに付随するタグ<br>
      文字列を配列で渡す（ない場合は空の配列を送る）
    EOS
    param :thumb, String, :required => false, :desc => 'サムネイル'
    param :user_name, String, :required => false, :desc => 'ユーザネーム（任意）'
  end
  description <<-EOS
    ## Example Params
    **POST Data (required url encode)** : `posts[title]=たいとる&posts[desc]=説明&posts[post_type]=1&posts[category]=2&posts[tags][]=hoge&posts[tags][]=fuga&posts[thumb]=/Users/tadayuki/hoge.jpg&posts[contents][0][order]=1&posts[contents][0][content_type]=2&posts[contents][0][details][0][substance]=1145737&posts[contents][0][details][0][detail_type]=1&posts[contents][1][order]=2&posts[contents][1][content_type]=2&posts[contents][1][details][0][substance]=1145737&posts[contents][1][details][0][detail_type]=1&posts[contents][2][order]=3&posts[contents][2][content_type]=2&posts[contents][2][details][0][substance]=1145737&posts[contents][2][details][0][detail_type]=1&posts[contents][3][order]=4&posts[contents][3][content_type]=2&posts[contents][3][details][0][substance]=1145737&posts[contents][3][details][0][detail_type]=1`
    ### Transform post data to json
    <pre class="prettyprint">
    {
      "posts": {
        "category": 2,
        "contents": [
          {
            "details": [
              {
                "detail_type": 1,
                "substance": "1145737"
              }
            ],
            "order": 1,
            "content_type": 2
          },
          {
            "details": [
              {
                "detail_type": 1,
                "substance": "1145737"
              }
            ],
            "order": 2,
            "content_type": 2
          },
          {
            "details": [
              {
                "detail_type": 1,
                "substance": "1145737"
              }
            ],
            "order": 3,
            "content_type": 2
          },
          {
            "details": [
              {
                "detail_type": 1,
                "substance": "1145737"
              }
            ],
            "order": 4,
            "content_type": 2
          }
        ],
        "desc": "説明",
        "post_type": 1,
        "tags": [
          "hoge",
          "fuga"
        ],
        "thumb": "/Users/tadayuki/hoge.jpg",
        "title": "たいとる"
      }
    }
    </pre>
  EOS
  example <<-EOS
    {
      "content": {
        "result": true
      },
      "user_hash": "fca8c9fd9fd9476f9ebd3eb841e4bfb4"
    }
  EOS
  def create
  end

end