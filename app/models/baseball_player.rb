class BaseballPlayer < Player
	belongs_to :baseball_team
	# has_many :baseball_projections

  embedded_in :baseball_projections, :inverse_of => :baseball_player
end
