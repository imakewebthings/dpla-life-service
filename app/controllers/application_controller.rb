class ApplicationController < ActionController::Base
  before_filter :set_default_format

  def set_default_format
    request.format = 'json' unless params[:format]
  end
end
