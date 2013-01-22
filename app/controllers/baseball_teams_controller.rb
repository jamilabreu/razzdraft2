class BaseballTeamsController < ApplicationController
	def create
		@baseball_team = BaseballTeam.new(params[:baseball_team])
		@baseball_team.user = current_user
		@baseball_team.save
		redirect_to root_path
	end
end