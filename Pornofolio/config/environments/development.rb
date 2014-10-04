Pornofolio::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Bulletの設定
  config.after_initialize do
    Bullet.enable = true # Bulletプラグインを有効
    Bullet.alert = true # JavaScriptでの通知
    Bullet.bullet_logger = true # log/bullet.logへの出力
    Bullet.console = true # ブラウザのコンソールログに記録
    Bullet.rails_logger = true # Railsログに出力
  end

  # メール送信に関するエラーをログに出力
  config.action_mailer.raise_delivery_errors = true
  # メール送信用の設定
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
      :enable_starttls_auto => true,
      :address              => 'smtp.gmail.com',
      :port                 => '587',
      :domain               => 'gmail.com',
      :authentication       => 'plain',
      :user_name            => 'tt.tanishi100@gmail.com',
      :password             => '12011103',
      :password             => 'ykefyxnfifewsaop'
  }
end
