module Doc::Ads
  extend Apipie::DSL::Concern

  api :GET, '/:resource_id', '表示する広告一覧を取得するAPI'
  formats ['json']
  error 400, 'パラメータエラー'
  error 503, 'データベースエラー'
  param :side, Integer, :required => false, :desc => <<-EOS
    右カラム用の広告の個数<br>
    デフォルトで`3`
  EOS
  param :footer, Integer, :required => false, :desc => <<-EOS
    右カラム用の広告の個数<br>
    デフォルトで`3`
  EOS
  description <<-EOS
    ## Example Params
    **GET Data (required url encode)** : `side=3&footer=3`
    ### Transform get data to json
    <pre class="prettyprint">
    {
      "side": 3,
      "footer": 3
    }
    </pre>
  EOS
  example <<-EOS
    {
      "content": {
        "footer": [
          {
            "ad_object": "<script type="text/javascript">var b="ript>",a='<script type="text/javascript" src="',imobile_pid="27811",imobile_asid="203278",imobile_width=300,imobile_height=250;document.write(a+'http://spdeliver.i-mobile.co.jp/script/adcore.js?20110201"></sc'+b);document.write(a+'http://spdeliver.i-mobile.co.jp/script/adcore_pc.js?20110201" defer></sc'+b);</script>",
            "id": 1
          },
          {
            "ad_object": "<script type="text/javascript" src="//pornfolio.jp/api/ads/tenga/3" defer></script>",
            "id": 4
          },
          {
            "ad_object": "<script type="text/javascript" src="//yichaad.durasite.net/A-affiliate2/mobile?site=6&keyword=Pornfolio_300_250_1&isJS=true" defer></script>",
            "id": 5
          }
        ],
        "side": [
          {
            "ad_object": "<script type="text/javascript">var b="ript>",a='<script type="text/javascript" src="',imobile_pid="27811",imobile_asid="203278",imobile_width=300,imobile_height=250;document.write(a+'http://spdeliver.i-mobile.co.jp/script/adcore.js?20110201"></sc'+b);document.write(a+'http://spdeliver.i-mobile.co.jp/script/adcore_pc.js?20110201" defer></sc'+b);</script>",
            "id": 1
          },
          {
            "ad_object": "<script type="text/javascript" src="//pornfolio.jp/api/ads/tenga/1" defer></script>",
            "id": 2
          },
          {
            "ad_object": "<script type="text/javascript" src="//pornfolio.jp/api/ads/tenga/2" defer></script>",
            "id": 3
          }
        ]
      },
      "user_hash": "a1958bd6c6a94dc0a3af9070e3234d7b"
    }
  EOS
  def index
  end


  api :POST, '/:resource_id', 'どの広告がクリックされたかを測定する'
  formats ['json']
  error 400, 'パラメータエラー'
  error 503, 'データベースエラー'
  param :ad, Hash, :required => true, :desc => 'クリックされた広告全体' do
    param :ad_id, Integer, :required => true, :desc => '広告のID'
    param :view_url, String, :required => true, :desc => '広告を見ているサイトのURL'
    param :post_id, Integer, :required => false, :desc => <<-EOS
      どのPostの広告を見てるかの`post_id`<br>
      TOPページやお気に入り一覧では必要なし
    EOS
  end
  description <<-EOS
    ## Example Params
    **POST Data (required url encode)** : `ad[ad_id]=1&ad[view_url]=http://pornfolio.jp&ad[post_id]=2`
    ### Transform post data to json
    <pre class="prettyprint">
    {
      "ad" : {
        "ad_id": 1,
        "view_url": "http://pornfolio.jp",
        "post_id": 2
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