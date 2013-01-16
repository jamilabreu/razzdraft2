class BaseballPlayer < Player
  embedded_in :baseball_projections, :inverse_of => :baseball_player
end
