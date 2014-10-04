class BetaController < ApplicationController
  resource_description { resource_id @controller.try(:controller_path) || controller_path }
  include Doc::Beta

  BETA_USER_PASS = 'b2f4bec'.freeze

  def auth
    pass = param_pass
    if BETA_USER_PASS != pass
      set_error :param, {message: 'Authentication error.'}
    else
      beta = Beta.update_or_create @access_user[:id]
      cookies[:beta] = { :value => beta[:beta_hash], :expires => 2.hour.from_now }
    end
  end

  def param_pass
    params.require(:pass)
  end
end
