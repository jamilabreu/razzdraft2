class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def load_sport
  	@sport = request.subdomain.present? && request.subdomain != "razzdraft" ? request.subdomain : "baseball"
  end
end
