class ProjectionsController < ApplicationController
  def show_blurb
  	@projection = BaseballProjection.find(params[:id])
  end
end
