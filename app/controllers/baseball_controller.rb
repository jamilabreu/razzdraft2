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
    @team = BaseballTeam.where(user_id: current_user.id).first
    @projection = BaseballProjection.find(params[:id])



    # Check Position Availability
    if @team && @team.send(params[:position].to_s).present? && (@team.send(params[:position].to_s).length >= @team.send("#{params[:position_name]}_max".to_sym).to_i)
      # If Batter
      if (@projection.positions & ["SP","RP"]).empty?
        # Check UTIL Availability
        if @team.send(:"UTIL").present? && (@team.send(:"UTIL").length >= @team.send(:util_max).to_i)
          redirect_to root_path, notice: "All slots for #{params[:position]} are full. Please remove a player to add #{@projection.name}."
        else
          # Add as UTIL
            @team.baseball_projections << @projection
            @team.add_to_set(:"UTIL", @projection.id)

            # Counter
            @team.inc(:batters, 1)
            @team.add_to_set(:averages, @projection.average)
            # Average Stats
            @average = ((@team.averages.inject(:+))/@team.batters.to_f)
            @team.update_attribute(:average, @average)
            # Add Stats
            %w( runs homeruns rbi steals ).each do |stat|
              @team.inc(stat.to_sym, @projection.send(stat.to_sym))
            end
            redirect_to root_path
        end
      # If Pitcher
      else
        # Check P Availability
        if @team.send(:"P").present? && (@team.send(:"P").length >= @team.send(:pitcher_max).to_i)
          redirect_to root_path, notice: "All slots for #{params[:position]} are full. Please remove a player to add #{@projection.name}."
        else
          # Add as P
            @team.baseball_projections << @projection
            @team.add_to_set(:"P", @projection.id)

            # Counter
            @team.inc(:pitchers, 1)
            # Add Stats
            %w( wins losses strikeouts saves ).each do |stat|
              @team.inc(stat.to_sym, @projection.send(stat.to_sym))
            end
            redirect_to root_path
        end
      end
    else
      # Add Player
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
      @team.pull(:"UTIL", @projection.id)

      # Average Stats
      if @team.averages.present?
        @average = ((@team.averages.inject(:+))/@team.batters.to_f)
        @team.update_attribute(:average, @average)
      else
        @team.update_attribute(:average, 0)
      end
    else
      @team.inc(:pitchers, -1)
      @team.pull(:"P", @projection.id)
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
