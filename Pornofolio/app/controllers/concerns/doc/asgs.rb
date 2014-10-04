module Doc::Asgs
  extend Apipie::DSL::Concern

  api :GET, '/:resource_id/thumbnails', 'アゲサゲのサムネイルを取得する'
  formats ['json']
  error 400, 'パラメータエラー'
  error 503, 'スクレイピングエラー、データベースエラー'
  param :id, String, :required => true, :desc => 'アゲサゲのvideoID'
  param :size, String, :required => false, :desc => <<-EOS
    サムネイルのサイズを指定
    * デフォルトで`140x105`
    * `xs`で`80x60`
    * `s`で`100x75`
    * `l`で`150x111`
    * `xl`で`200x148`
    * `h`で`450x338`
  EOS
  description <<-EOS
    ## Example Params
    **GET Data (required url encode)** : `id=erprdBcsNinGFGOd&size=l`
    ### Transform get data to json
    <pre class="prettyprint">
    {
      "id": "erprdBcsNinGFGOd",
      "size": "l"
    }
    </pre>
  EOS
  example <<-EOS
  {
    "content": {
      "thumbnails": [
        "http://smedia21.asg.to/t/20140203/1391404178_68464_358678.flv/150x111/0",
        "http://smedia21.asg.to/t/20140203/1391404178_68464_358678.flv/150x111/1",
        ...
        "http://smedia21.asg.to/t/20140203/1391404178_68464_358678.flv/150x111/24",
        "http://smedia21.asg.to/t/20140203/1391404178_68464_358678.flv/150x111/25"
      ],
      "video_id": "erprdBcsNinGFGOd"
    },
    "user_hash": "a1958bd6c6a94dc0a3af9070e3234d7b"
  }
  EOS
  def thumbnails
  end


end