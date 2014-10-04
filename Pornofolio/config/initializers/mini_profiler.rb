# rack-mini-profilerをデフォルトで非表示にする設定
# 計測が必要なときはURLの末尾に ?pp=enable を付けてください
# サーバーを再起動しないで元に戻す場合は ?pp=disable を付けてください

if defined?(Rack::MiniProfiler)
  Rack::MiniProfiler.config.enabled = true
end