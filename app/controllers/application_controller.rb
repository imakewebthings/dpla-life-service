class ApplicationController < ActionController::Base
  require 'active_record/validations'
  require 'active_record/errors'

  before_filter :set_default_format

  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  rescue_from ActiveRecord::RecordInvalid, :with => :render_422

  def set_default_format
    request.format = 'json' unless params[:format]
  end

  def render_404(invalid)
    head 404
  end

  def render_422(invalid)
    @errors = invalid.record.errors.to_a
    render 'errors/422', status: 422
  end

  def auth_and_get_user
    authenticate_or_request_with_http_token do |token, options|
      @user = User.find_by_token token
    end
  end
end
