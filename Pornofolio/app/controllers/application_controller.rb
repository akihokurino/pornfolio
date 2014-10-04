class ApplicationController < ActionController::Base
  include ActionController::StrongParameters
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :set_headers, :user_log
  after_action :save_user_log

  class BetaAuthError < StandardError;end

  rescue_from Exception, :with => :error_500 if Rails.env.production?
  rescue_from StandardError,                       :with => :error_503
  rescue_from Encoding::CompatibilityError,        :with => :error_500
  rescue_from BetaAuthError,      :with => :error_401
  rescue_from ActionController::ParameterMissing,  :with => :error_400
  rescue_from ActionController::UnpermittedParameters, :with => :error_400
  rescue_from ActiveRecord::RecordNotFound,       :with => :error_404
  rescue_from ActionController::RoutingError,     :with => :error_404


  # エラー用の定数
  JSON_ERROR = {
      general: {
          message: 'An error has occurred.',
          status: 503
      },
      param: {
          message: 'Parameter is invalid.',
          status: 400
      },
      not_found: {
          message: 'Page is not found.',
          status: 404
      },
      server: {
          message: 'Internal server error.',
          status: 500
      },
      auth: {
          message: 'Authentication is failed.',
          status: 401
      }
  }.freeze


  def error_500(exception = nil)
    save_error_log(exception)
    set_error :server
  end

  def error_503(exception = nil)
    save_error_log(exception)
    set_error
  end

  def error_404(exception = nil)
    save_error_log(exception)
    set_error :not_found
  end

  def error_400(exception = nil)
    save_error_log(exception)
    set_error :param
  end

  def error_401(exception = nil)
    save_error_log(exception)
    set_error :auth
  end

  def cors_preflight_check
    head :no_content
  end

  private
  def set_headers
    origin_regex = Regexp.new(Settings.cors.origin_regex, Regexp::IGNORECASE)
    if request.headers["HTTP_ORIGIN"] && origin_regex.match(request.headers["HTTP_ORIGIN"])
      headers['Access-Control-Allow-Origin'] = request.headers["HTTP_ORIGIN"]
      Settings.cors[Rails.env.to_s].headers.each { |k, v| headers[k.to_s] = v }
    end
  end

  # エラーを吐くためのメソッド
  def set_error(name = :general, option = {})
    @error = {message: JSON_ERROR[name][:message]}
    status = JSON_ERROR[name][:status]

    @error = option[:message] if option[:message].present?
    status = option[:status] if option[:status].present?
    @error[:status] = status
    render :status => status, :layout => false, :template => 'errors/error'
  end

  # エラーログの保存
  def save_error_log(exception)
    logger.error(exception) if exception
  end

  # ユーザログの値を設定
  def user_log
    @user_log = {}
    @access_user = User.find_or_create(cookies[:user_hash])

    @user_hash = cookies.permanent[:user_hash] = @access_user[:hash_value]
    @user_log[:user_id]        = @access_user[:id]
    @user_log[:ip]             = request.env["HTTP_X_FORWARDED_FOR"] || request.remote_ip
    @user_log[:referer]        = request.env['HTTP_REFERER']
    @user_log[:user_agent]     = request.env['HTTP_USER_AGENT']
    @user_log[:access_url]     = request.env['PATH_INFO']
    @user_log[:request_method] = request.request_method
  end

  # アクセスログの保存
  def save_user_log
    access_log = AccessLog.create(@user_log)
    # アクセスログの測定はバッチ処理に変更
    # IpInfoWorker.perform_async access_log[:id], access_log[:ip]
  rescue => ex
    logger.error(ex)
  end
end
