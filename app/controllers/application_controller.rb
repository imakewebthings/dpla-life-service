class ApplicationController < ActionController::Base
  require 'active_record/validations'

  before_filter :set_default_format

  rescue_from ActiveRecord::RecordInvalid, :with => :render_422

  def set_default_format
    request.format = 'json' unless params[:format]
  end

  def render_422(invalid)
    @errors = invalid.record.errors.to_a
    render 'errors/422', status: 422
  end
end
