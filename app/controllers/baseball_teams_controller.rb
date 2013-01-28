class BaseballTeamsController < ApplicationController
	def new
		@baseball_team = BaseballTeam.new
	end
	def create
		@baseball_team = BaseballTeam.new(params[:baseball_team])
		@baseball_team.user = current_user
		@baseball_team.save
		redirect_to root_path, notice: "Team created! If you want to delete this team, click the Settings dropdown tab at the top right of your screen."
	end

	def destroy
		@baseball_team = BaseballTeam.find(params[:id])
    @baseball_team.destroy
    redirect_to root_path
	end

	def yahoo_league
		@baseball_team = BaseballTeam.create(
			catcher_max: 1,
			first_base_max: 1,
			second_base_max: 1,
			shortstop_max: 1,
			third_base_max: 1,
			outfield_max: 3,
			util_max: 2,
			starter_max: 2,
			reliever_max: 2,
			pitcher_max: 4,
			bench_max: 3,
			league_type: "yahoo"
		)
		@baseball_team.user = current_user
		@baseball_team.save
		redirect_to root_path
	end

	def espn_league
		@baseball_team = BaseballTeam.create(
			catcher_max: 1,
			first_base_max: 1,
			second_base_max: 1,
			shortstop_max: 1,
			third_base_max: 1,
			outfield_max: 5,
			util_max: 1,
			pitcher_max: 9,
			middle_infielder_max: 1,
			corner_infielder_max: 1,
			bench_max: 3,
			league_type: "espn"
  	)
		@baseball_team.user = current_user
		@baseball_team.save
		redirect_to root_path
	end
end

# Roster: ESPN Default Format: C/1B/2B/SS/3B/5 OF/CI/MI/UTIL/9 P.
# Yahoo! Default Format: C/1B/2B/SS/3B/3 OF/2 UTIL/2 SP/2 RP/4 P