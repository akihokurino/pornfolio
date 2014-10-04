# db/adのjsonファイルを取得
ad_init_file = Dir.glob(File.join(Rails.root,'db/ad','*.json'))

ad_init_file.each do |file|
  ad_data = JSON.parse(File.read(file), {:symbolize_names => true})
  # urlがある分ループを回してseedを入れる
  ad_data[:ad_object].each do |object|
    Ad.seed(:ad_object) do |s|
      s.ad_object  = object[:content]
      s.company    = ad_data[:company]
      s.ad_type    = object[:type]
    end
  end
end