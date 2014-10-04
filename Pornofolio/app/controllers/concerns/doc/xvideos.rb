module Doc::Xvideos
  extend Apipie::DSL::Concern

  api :GET, '/:resource_id/thumbnails', 'Xvideosのサムネイルを取得する'
  formats ['json']
  error 400, 'パラメータエラー'
  error 503, 'スクレイピングエラー、データベースエラー'
  param :id, Integer, :required => true, :desc => 'xvideosのvideoID'
  param :size, String, :required => false, :desc => <<-EOS
    サムネイルのサイズを指定
    * デフォルトで`180x135`
    * `l`で`240x180`
    * `ll`で`399x300`
    * `lll`で`487x366`
  EOS
  description <<-EOS
    ## Example Params
    **GET Data (required url encode)** : `id=4754720&size=l`
    ### Transform get data to json
    <pre class="prettyprint">
    {
      "id": 4754720,
      "size": "l"
    }
    </pre>
  EOS
  example <<-EOS
    {
      "content": {
        "thumbnails": [
          "http://img100.xvideos.com/videos/thumbs/5a/68/e2/5a68e258585f5400ca59f53b48235fa5/5a68e258585f5400ca59f53b48235fa5.1.jpg",
          "http://img100.xvideos.com/videos/thumbs/5a/68/e2/5a68e258585f5400ca59f53b48235fa5/5a68e258585f5400ca59f53b48235fa5.2.jpg",
          ...
          "http://img100.xvideos.com/videos/thumbs/5a/68/e2/5a68e258585f5400ca59f53b48235fa5/5a68e258585f5400ca59f53b48235fa5.29.jpg",
          "http://img100.xvideos.com/videos/thumbs/5a/68/e2/5a68e258585f5400ca59f53b48235fa5/5a68e258585f5400ca59f53b48235fa5.30.jpg"
        ],
        "video_id": "4754720"
      },
      "user_hash": "b042f62059ea4910a66579e2cf100784"
    }
  EOS
  def thumbnails
  end


end