class BaseballController < ApplicationController
  def index
  	@available = BaseballProjection.asc(:rank)
  end

  def search
  	if params[:query]
  		@projections = BaseballProjection.where("baseball_player.name" => /#{params[:query]}/i).asc(:rank)
  	elsif params[:position].present?
  		position = params[:position] == "MI" ? ["2B","SS"] : params[:position] == "CI" ? ["1B","3B"] : params[:position] == "P" ? position = ["SP","RP"] : params[:position].to_a
  		@projections = BaseballProjection.any_in("baseball_player.positions" => position).asc(:rank)
  	else
  		@projections = BaseballProjection.asc(:rank)
  	end
  end
end
