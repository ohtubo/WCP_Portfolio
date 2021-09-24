require 'json' # ハッシュからjson形式に変換（データ形式）
require 'net/https'

module Translation
  class << self
    def get_Translation_data(image_data)
      # APIのURL作成
      api_url = "https://translation.googleapis.com/language/translate/v2?key=#{ENV['GOOGLE_API_KEY']}"

      # APIリクエスト用のJSONパラメータ
      params = {
        "q": "#{image_data}",
        "source": "en",
        "target": "ja",
        "format": "text",
      }.to_json

      # Google Cloud Vision APIにリクエスト
      uri = URI.parse(api_url)
      # RubyのライブラリNet::HTTPで取ってくるデータをカバーする。 #Ruby: Net::HTTP で調べる。
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request['Content-Type'] = 'application/json'
      response = https.request(request, params)
      response_body = JSON.parse(response.body)
      #----------------------------------------------------------
      pp response_body
      # JSON レスポンスが返されます。
      # {"data"=>{"translations"=>[{"translatedText"=>"馬"}]}} {}:通常の変数　[]配列の為単体でも[0]必要
      response_body['data']['translations'][0]['translatedText']
    end
  end
end
