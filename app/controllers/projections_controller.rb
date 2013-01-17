class ProjectionsController < ApplicationController
	def index
		if @sport == "football"
			@available = FootballProjection.desc(:touchdowns)
		else
			if current_user.try(:baseball_team)
				@drafted = BaseballProjection.any_in(id: current_user.baseball_team.baseball_projection_ids)
				@available = BaseballProjection.not_in(id: current_user.baseball_team.baseball_projection_ids).order_by(sort_by.send(sort_direction))
				@hitters_hash = { "catcher" => "C",
					"first_base" => "1B",
					"second_base" => "2B",
					"shortstop" => "SS",
					"third_base" => "3B",
					"outfield" => "OF",
					"utility" => "UTIL"}
				@pitchers_hash = {
					"starter" => "SP",
					"reliever" => "RP" }
				@hitters_hash.merge(@pitchers_hash).each do |variable, method|
					instance_variable_set("@#{variable}", BaseballProjection.any_in(id: current_user.baseball_team.send(method.to_sym)))
				end
			else
				@available = BaseballProjection.all#order_by(sort_by.send(sort_direction))
			end

			stat = params[:sort] ? params[:sort].to_sym : :rank
			sort_direction = params[:direction] ? params[:direction] : :asc
			@available = @available.order_by(stat.send(sort_direction))
			if [:losses, :era, :whip].include?(stat)
				@available = @available.gt(stat => 0)
			end

			if params[:position] && params[:position] != "ALL"
				position = params[:position] == "MI" ? ["2B","SS"] : params[:position] == "CI" ? ["1B","3B"] : params[:position] == "P" ? ["SP","RP"] : params[:position] == "UTIL" ? ["C","1B","2B","3B","SS","OF"] : params[:position].to_a
				@available = @available.any_in(positions: position)
			end
		end
	end

  def show_blurb
  	@projection = BaseballProjection.find(params[:id])
  end
end
