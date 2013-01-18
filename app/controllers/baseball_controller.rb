class BaseballController < ApplicationController

  def search
  	# if params[:query]
  		@projections = BaseballProjection.where(name: /#{params[:query]}/i)
  	# elsif params[:position].present?
  	# 	position = params[:position] == "MI" ? ["2B","SS"] : params[:position] == "CI" ? ["1B","3B"] : params[:position] == "P" ? ["SP","RP"] : params[:position] == "UTIL" ? ["C","1B","2B","3B","SS","OF"] : params[:position].to_a
  	# 	@projections = BaseballProjection.any_in(positions: position)
  	# else
  	# 	@projections = BaseballProjection.all
  	# end
  end

  def draft_player
    @team = BaseballTeam.find_or_create_by(user_id: current_user.id)
    @projection = BaseballProjection.find(params[:id])
    @team.baseball_projections << @projection
    @team.add_to_set(params[:position].to_sym, @projection.id)

    # Counter
    if (@projection.positions & ["SP","RP"]).empty?
      @team.inc(:batters, 1)
      @team.add_to_set(:averages, @projection.average)
      # Average Stats
      @average = ((@team.averages.inject(:+))/@team.batters.to_f)
      @team.update_attribute(:average, @average)
    else
      @team.inc(:pitchers, 1)
    end

    # Add Stats
    %w( runs homeruns rbi steals wins losses strikeouts saves).each do |stat|
      @team.inc(stat.to_sym, @projection.send(stat.to_sym))
    end

    redirect_to root_path
  end

  def undraft_player
    @team = BaseballTeam.find_or_create_by(user_id: current_user.id)
    @projection = BaseballProjection.find(params[:id])
    @team.baseball_projections.delete(@projection)
    @team.pull(params[:position].to_sym, @projection.id)

    # Counter
    if (@projection.positions & ["SP","RP"]).empty?
      @team.inc(:batters, -1)
      @team.pull(:averages, @projection.average)
      # Average Stats
      if @team.averages.present?
        @average = ((@team.averages.inject(:+))/@team.batters.to_f)
        @team.update_attribute(:average, @average)
      else
        @team.update_attribute(:average, 0)
      end
    else
      @team.inc(:pitchers, -1)
    end

    # Remove Stats
    %w( runs homeruns rbi steals wins losses strikeouts saves).each do |stat|
      @team.inc(stat.to_sym, -(@projection.send(stat.to_sym)))
    end

    redirect_to root_path
  end

  def remove_player
    @team = BaseballTeam.find_or_create_by(user_id: current_user.id)
    @projection = BaseballProjection.find(params[:id])
    @team.add_to_set(:removed, @projection.id)
    redirect_to root_path
  end

  def restore_player
    @team = BaseballTeam.find_or_create_by(user_id: current_user.id)
    @projection = BaseballProjection.find(params[:id])
    @team.pull(:removed, @projection.id)
    redirect_to root_path
  end

  def removed_players
    @removed = BaseballProjection.any_in(id: current_user.baseball_team.removed)
  end
end
