class ProjectionsController < ApplicationController
	def index
		@team = BaseballTeam.where(user_id: current_user.id).first if user_signed_in?
		@league_type = params[:league_type] ? params[:league_type] : @team.present? ? @team.league_type : "yahoo"
		@league_size = @team.present? ? @team.league_size : 10
		@hitters_hash = { "catcher" => "C",
			"first_base" => "1B",
			"second_base" => "2B",
			"shortstop" => "SS",
			"third_base" => "3B",
			"middle_infielder" => "MI",
			"corner_infielder" => "CI",
			"outfield" => "OF",
			"util" => "UTIL"
		}
		@pitchers_hash = {
			"starter" => "SP",
			"reliever" => "RP",
			"pitcher" => "P"
		}
		@positions_hash = @hitters_hash.merge(@pitchers_hash)

		if current_user.try(:baseball_team)
			drafted_ids = current_user.baseball_team.baseball_projection_ids || []
			removed_ids = current_user.baseball_team.removed || []
			@drafted = BaseballProjection.any_in(id: drafted_ids)
			@removed = BaseballProjection.any_in(id: removed_ids)
			@available = BaseballProjection.not_in(id: drafted_ids + removed_ids)
		else
			@available = BaseballProjection.all
		end

		# Sort Logic
		sort_by = params[:sort] ? params[:sort].to_sym : :rank
		sort_direction = params[:direction] ? params[:direction] : :asc
		@available = @available.order_by(sort_by.send(sort_direction))
		if [:losses, :era, :whip].include?(sort_by)
			@available = @available.gt(sort_by => 0)
		end

		# Position Filter Logic
		if params[:position] && params[:position] != "ALL"
			position = params[:position] == "MI" ? ["2B","SS"] : params[:position] == "CI" ? ["1B","3B"] : params[:position] == "P" ? ["SP","RP"] : params[:position] == "UTIL" ? ["C","1B","2B","3B","SS","OF","UTIL"] : params[:position].to_a
			@available = @available.any_in("#{@league_type}_positions" => position)
		end
	end

  def show_blurb
  	@projection = BaseballProjection.find(params[:id])
  end

# @positions_hash.each do |variable, method|
# 	instance_variable_set("@#{variable}", BaseballProjection.any_in(id: current_user.baseball_team.send(method.to_sym)))
# end
end
