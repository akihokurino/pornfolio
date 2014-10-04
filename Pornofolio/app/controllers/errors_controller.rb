class ErrorsController < ApplicationController

  def auth_failed
    set_error :redirect
  end

end
