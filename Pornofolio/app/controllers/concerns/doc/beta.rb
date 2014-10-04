module Doc::Beta
  extend Apipie::DSL::Concern

  api :POST, '/:resource_id', 'Beta版のためのcookieの設定'
  formats ['json']
  error 400, 'パラメータエラー、認証エラー'
  param :pass, String, :required => true, :desc => '`b2f4bec`が送られて来たら`cookie["beta"]`を設定する'
  description <<-EOS
    ## Example Params
    **POST Data** : `pass=b2f4bec`
    ### Transform get data to json
    <pre class="prettyprint">
    {
      "pass": "b2f4bec"
    }
    </pre>
  EOS
  example <<-EOS
    {
      "content": {
        "result": true
      },
      "user_hash": "b042f62059ea4910a66579e2cf100784"
    }
  EOS
  def auth
  end
end