class ApplicationController < ActionController::Base
  protect_from_forgery

  respond_to :html, :json, :text, :pdf
  before_filter :default_format, :set_header, :check_seed


  def default_format
    logger.info(params[:format])
    request.format = "json" unless params[:format]
  end

  def set_header
    if params[:format].blank?
      headers["Content-Type"] = "text/plain"
    end
  end

  def check_seed
    load(Rails.root.join("db", "seeds.rb")) if Revision.count < 1
  end
end
