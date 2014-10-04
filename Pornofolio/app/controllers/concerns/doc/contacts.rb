module Doc::Contacts
  extend Apipie::DSL::Concern

  api :POST, '/:resource_id', '問い合わせのメールを送るAPI'
  formats ['json']
  error 400, 'パラメータエラー'
  error 500, 'メーラーエラー'
  param :contact, Hash, :required => true, :desc => '問い合わせ全体' do
    param :name, String, :required => true, :desc => 'ユーザー名'
    param :body, String, :required => true, :desc => '問い合わせ内容'
  end
  description <<-EOS
    ## Example Params
    **POST Data (required url encode)** : `contact[name]=名無しがお送りします&contact[body]=問い合わせは◯◯です。`
    ### Transform post data to json
    <pre class="prettyprint">
    {
      "contact": {
        "name": "名無しがお送りします",
        "body": "問い合わせは◯◯です。"
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