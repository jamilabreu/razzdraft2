class ProjectionsController < ApplicationController
	before_filter :load_sport

	def index
		if @sport == "football"
			@available = FootballProjection.desc(:touchdowns)
		else
			if current_user.try(:baseball_team)
				@drafted = BaseballProjection.any_in(id: current_user.baseball_team.baseball_projection_ids)
				@available = BaseballProjection.not_in(id: current_user.baseball_team.baseball_projection_ids).asc(:rank)
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
				@available = BaseballProjection.asc(:rank)
			end
		end
	end

  def show_blurb
  	@projection = BaseballProjection.find(params[:id])
  end
end
