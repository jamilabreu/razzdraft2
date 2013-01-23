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
    @league_type = @team.league_type

    # If Position Full
    if @team && @team.send(params[:position].to_s).present? && (@team.send(params[:position].to_s).length >= @team.send("#{params[:position_name]}_max".to_sym).to_i)
      # If Batter
      if (@projection.send("#{@league_type}_positions") & ["SP","RP"]).empty?
        # If MI
        if params[:position] == "2B" || params[:position] == "SS"
          # If MI Full
          if @team.send(:"MI").present? && (@team.send(:"MI").length >= @team.send(:middle_infielder_max).to_i)
            # If UTIL Full
            if @team.send(:"UTIL").present? && (@team.send(:"UTIL").length >= @team.send(:util_max).to_i)
              # If BENCH Full
              if @team.send(:"BENCH").present? && (@team.send(:"BENCH").length >= @team.send(:bench_max).to_i)
                redirect_to root_path(league_type: params[:league_type]), notice: "All slots for #{params[:position]} are full. Please remove a player to add #{@projection.name}."
              else
                # Add as BENCH
                  @team.baseball_projections << @projection
                  @team.add_to_set(:"BENCH", @projection.id)
                  # Add Stats
                  %w( hits at_bats plate_appearances times_on_base runs homeruns rbi steals ).each do |stat|
                    @team.inc(stat.to_sym, @projection.send(stat.to_sym))
                  end
                  # Calculate New Team Average / OBP
                  @average = (@team.hits.to_f/@team.at_bats)
                  @obp = (@team.times_on_base.to_f/(@team.times_on_base - @team.hits + @team.at_bats))
                  @team.update_attributes!(average: @average, obp: @obp)
                  redirect_to root_path(league_type: params[:league_type])
              end
            else
              # Add as UTIL
                @team.baseball_projections << @projection
                @team.add_to_set(:"UTIL", @projection.id)
                # Add Stats
                %w( hits at_bats plate_appearances times_on_base runs homeruns rbi steals ).each do |stat|
                  @team.inc(stat.to_sym, @projection.send(stat.to_sym))
                end
                # Calculate New Team Average / OBP
                @average = (@team.hits.to_f/@team.at_bats)
                @obp = (@team.times_on_base.to_f/(@team.times_on_base - @team.hits + @team.at_bats))
                @team.update_attributes!(average: @average, obp: @obp)
                redirect_to root_path(league_type: params[:league_type])
            end
          else
            # Add as MI
            @team.baseball_projections << @projection
            @team.add_to_set(:"MI", @projection.id)
            # Add Stats
            %w( hits at_bats plate_appearances times_on_base runs homeruns rbi steals ).each do |stat|
              @team.inc(stat.to_sym, @projection.send(stat.to_sym))
            end
            # Calculate New Team Average / OBP
            @average = (@team.hits.to_f/@team.at_bats)
            @obp = (@team.times_on_base.to_f/(@team.times_on_base - @team.hits + @team.at_bats))
            @team.update_attributes!(average: @average, obp: @obp)
            redirect_to root_path(league_type: params[:league_type])
          end
        # IF CI
        elsif params[:position] == "1B" || params[:position] == "3B"
         # If CI Full
          if @team.send(:"CI").present? && (@team.send(:"CI").length >= @team.send(:corner_infielder_max).to_i)
            # If UTIL Full
            if @team.send(:"UTIL").present? && (@team.send(:"UTIL").length >= @team.send(:util_max).to_i)
              # If BENCH Full
              if @team.send(:"BENCH").present? && (@team.send(:"BENCH").length >= @team.send(:bench_max).to_i)
                redirect_to root_path(league_type: params[:league_type]), notice: "All slots for #{params[:position]} are full. Please remove a player to add #{@projection.name}."
              else
                # Add as BENCH
                @team.baseball_projections << @projection
                @team.add_to_set(:"BENCH", @projection.id)
                # Add Stats
                %w( hits at_bats plate_appearances times_on_base runs homeruns rbi steals ).each do |stat|
                  @team.inc(stat.to_sym, @projection.send(stat.to_sym))
                end
                # Calculate New Team Average / OBP
                @average = (@team.hits.to_f/@team.at_bats)
                @obp = (@team.times_on_base.to_f/(@team.times_on_base - @team.hits + @team.at_bats))
                @team.update_attributes!(average: @average, obp: @obp)
                redirect_to root_path(league_type: params[:league_type])
              end
            else
              # Add as UTIL
                @team.baseball_projections << @projection
                @team.add_to_set(:"UTIL", @projection.id)
                # Add Stats
                %w( hits at_bats plate_appearances times_on_base runs homeruns rbi steals ).each do |stat|
                  @team.inc(stat.to_sym, @projection.send(stat.to_sym))
                end
                # Calculate New Team Average / OBP
                @average = (@team.hits.to_f/@team.at_bats)
                @obp = (@team.times_on_base.to_f/(@team.times_on_base - @team.hits + @team.at_bats))
                @team.update_attributes!(average: @average, obp: @obp)
                redirect_to root_path(league_type: params[:league_type])
            end
          else
            # Add as CI
              @team.baseball_projections << @projection
              @team.add_to_set(:"CI", @projection.id)
              # Add Stats
              %w( hits at_bats plate_appearances times_on_base runs homeruns rbi steals ).each do |stat|
                @team.inc(stat.to_sym, @projection.send(stat.to_sym))
              end
              # Calculate New Team Average / OBP
              @average = (@team.hits.to_f/@team.at_bats)
              @obp = (@team.times_on_base.to_f/(@team.times_on_base - @team.hits + @team.at_bats))
              @team.update_attributes!(average: @average, obp: @obp)
              redirect_to root_path(league_type: params[:league_type])
          end
        else
          # IF UTIL Full
          if @team.send(:"UTIL").present? && (@team.send(:"UTIL").length >= @team.send(:util_max).to_i)
            # If BENCH Full
            if @team.send(:"BENCH").present? && (@team.send(:"BENCH").length >= @team.send(:bench_max).to_i)
              redirect_to root_path(league_type: params[:league_type]), notice: "All slots for #{params[:position]} are full. Please remove a player to add #{@projection.name}."
            else
              # Add as BENCH
              @team.baseball_projections << @projection
              @team.add_to_set(:"BENCH", @projection.id)
              # Add Stats
              %w( hits at_bats plate_appearances times_on_base runs homeruns rbi steals ).each do |stat|
                @team.inc(stat.to_sym, @projection.send(stat.to_sym))
              end
              # Calculate New Team Average / OBP
              @average = (@team.hits.to_f/@team.at_bats)
              @obp = (@team.times_on_base.to_f/(@team.times_on_base - @team.hits + @team.at_bats))
              @team.update_attributes!(average: @average, obp: @obp)
              redirect_to root_path(league_type: params[:league_type])
            end
          else
            # Add as UTIL
              @team.baseball_projections << @projection
              @team.add_to_set(:"UTIL", @projection.id)
              # Add Stats
              %w( hits at_bats plate_appearances times_on_base runs homeruns rbi steals ).each do |stat|
                @team.inc(stat.to_sym, @projection.send(stat.to_sym))
              end
              # Calculate New Team Average / OBP
              @average = (@team.hits.to_f/@team.at_bats)
              @obp = (@team.times_on_base.to_f/(@team.times_on_base - @team.hits + @team.at_bats))
              @team.update_attributes!(average: @average, obp: @obp)
              redirect_to root_path(league_type: params[:league_type])
          end
        end
      # If Pitcher
      else
        # Check P Availability
        if @team.send(:"P").present? && (@team.send(:"P").length >= @team.send(:pitcher_max).to_i)
          # If BENCH Full
          if @team.send(:"BENCH").present? && (@team.send(:"BENCH").length >= @team.send(:bench_max).to_i)
            redirect_to root_path(league_type: params[:league_type]), notice: "All slots for #{params[:position]} are full. Please remove a player to add #{@projection.name}."
          else
            # Add as BENCH
            @team.baseball_projections << @projection
            @team.add_to_set(:"BENCH", @projection.id)
            # Add Stats
            %w( innings_pitched earned_runs basemen_allowed wins losses strikeouts saves ).each do |stat|
              @team.inc(stat.to_sym, @projection.send(stat.to_sym))
            end
            # Calculate New Team ERA / WHIP
            @era = (@team.earned_runs.to_f/@team.innings_pitched)*9
            @whip = (@team.basemen_allowed.to_f/@team.innings_pitched)
            @team.update_attributes!(era: @era, whip: @whip)
            redirect_to root_path(league_type: params[:league_type])
          end
        else
          # Add as P
          @team.baseball_projections << @projection
          @team.add_to_set(:"P", @projection.id)
          # Add Stats
          %w( innings_pitched earned_runs basemen_allowed wins losses strikeouts saves ).each do |stat|
            @team.inc(stat.to_sym, @projection.send(stat.to_sym))
          end
          # Calculate New Team ERA / WHIP
          @era = (@team.earned_runs.to_f/@team.innings_pitched)*9
          @whip = (@team.basemen_allowed.to_f/@team.innings_pitched)
          @team.update_attributes!(era: @era, whip: @whip)
          redirect_to root_path(league_type: params[:league_type])
        end
      end
    else
      # Add Player
      @team.baseball_projections << @projection
      @team.add_to_set(params[:position].to_sym, @projection.id)
      if (@projection.send("#{@league_type}_positions") & ["SP","RP","P"]).empty?
        # Add Stats
        %w( hits at_bats plate_appearances times_on_base runs homeruns rbi steals ).each do |stat|
          @team.inc(stat.to_sym, @projection.send(stat.to_sym))
        end
        # Calculate New Team Average / OBP
        @average = (@team.hits.to_f/@team.at_bats)
        @obp = (@team.times_on_base.to_f/(@team.times_on_base - @team.hits + @team.at_bats))
        @team.update_attributes!(average: @average, obp: @obp)
      else
        # Add Stats
        %w( innings_pitched earned_runs basemen_allowed wins losses strikeouts saves ).each do |stat|
          @team.inc(stat.to_sym, @projection.send(stat.to_sym))
        end
        # Calculate New Team ERA / WHIP
        @era = (@team.earned_runs.to_f/@team.innings_pitched)*9
        @whip = (@team.basemen_allowed.to_f/@team.innings_pitched)
        @team.update_attributes!(era: @era, whip: @whip)
      end
      redirect_to root_path(league_type: params[:league_type])
    end
  end

  def undraft_player
    @team = BaseballTeam.find_or_create_by(user_id: current_user.id)
    @projection = BaseballProjection.find(params[:id])
    @league_type = @team.league_type

    @team.baseball_projections.delete(@projection)

    %w( 1B 2B SS 3B MI CI OF UTIL SP RP P BENCH ).each do |position|
      @team.pull(position.to_sym, @projection.id)
    end
    if (@projection.send("#{@league_type}_positions") & ["SP","RP","P"]).empty?
      # Add Stats
      %w( hits at_bats plate_appearances times_on_base runs homeruns rbi steals ).each do |stat|
        @team.inc(stat.to_sym, -(@projection.send(stat.to_sym)))
      end
      # Calculate New Team Average / OBP
      @average = (@team.hits.to_f/@team.at_bats)
      @obp = (@team.times_on_base.to_f/(@team.times_on_base - @team.hits + @team.at_bats))
      @team.update_attributes!(average: @average.nan? ? 0 : @average, obp: @obp.nan? ? 0 : @obp)
    else
      # Add Stats
      %w( innings_pitched earned_runs basemen_allowed wins losses strikeouts saves ).each do |stat|
        @team.inc(stat.to_sym, -(@projection.send(stat.to_sym)))
      end
      # Calculate New Team ERA / WHIP
      @era = (@team.earned_runs.to_f/@team.innings_pitched)*9
      @whip = (@team.basemen_allowed.to_f/@team.innings_pitched)
      @team.update_attributes!(era: @era.nan? ? 0 : @era, whip: @whip.nan? ? 0 : @whip)
    end
    redirect_to root_path(league_type: params[:league_type])
  end

  def remove_player
    @team = BaseballTeam.find_or_create_by(user_id: current_user.id)
    @projection = BaseballProjection.find(params[:id])
    @team.add_to_set(:removed, @projection.id)
    redirect_to root_path(league_type: params[:league_type])
  end

  def restore_player
    @team = BaseballTeam.find_or_create_by(user_id: current_user.id)
    @projection = BaseballProjection.find(params[:id])
    @team.pull(:removed, @projection.id)
    redirect_to root_path(league_type: params[:league_type])
  end

  def removed_players
    @removed = BaseballProjection.any_in(id: current_user.baseball_team.removed)
  end
end
