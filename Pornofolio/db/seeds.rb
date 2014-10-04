# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# postを構成するサンプルデータ
ActiveRecord::Base.transaction do
  # seed_fuが実行されているかのチェック
  if PostType.ids.blank?
    puts "Please run 'rake db:seed_fu'. After that, run 'rake db:seed'."
    break
  end

  # ループ回数
  n = 30
  file_path = File.join(Rails.root,'db/sample','post.json')
  # post.jsonが無ければ処理を抜ける
  unless File.exist?(file_path)
    puts "#{File.basename(file_path)} is not found."
    break
  end
  post_data = JSON.parse(File.read(file_path), {:symbolize_names => true})
  user      = User.find_or_create
  n.times {
    post_data.each do |post|
      Post.relation_create(user[:id], post[:posts])
    end
  }
  puts "#{File.basename(file_path)} insert #{n} relation data."
  puts "You might run 'bundle exec sidekiq -C config/sidekiq.yml'."
end