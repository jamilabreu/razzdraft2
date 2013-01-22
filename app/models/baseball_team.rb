class BaseballTeam
  include Mongoid::Document
  belongs_to :user
  has_many :baseball_projections

  field :"C", type: Array
  field :"1B", type: Array
  field :"2B", type: Array
  field :"SS", type: Array
  field :"3B", type: Array
  field :"MI", type: Array
  field :"CI", type: Array
  field :"OF", type: Array
  field :"UTIL", type: Array
  field :"SP", type: Array
  field :"RP", type: Array
  field :"P", type: Array
  field :batters, type: Integer, default: ->{ 0 }
  field :pitchers, type: Integer, default: ->{ 0 }

  field :catcher_max
  field :first_base_max
  field :second_base_max
  field :shortstop_max
  field :third_base_max
  field :outfield_max
  field :util_max
  field :starter_max
  field :reliever_max
  field :pitcher_max
  field :middle_infielder_max
  field :corner_infielder_max

  field :runs, type: Integer, default: ->{ 0 }
  field :homeruns, type: Integer, default: ->{ 0 }
  field :rbi, type: Integer, default: ->{ 0 }
  field :average, type: Float, default: ->{ 0.000 }
  field :averages, type: Array
  field :steals, type: Integer, default: ->{ 0 }
  field :wins, type: Integer, default: ->{ 0 }
  field :losses, type: Integer, default: ->{ 0 }
  field :era, type: Float, default: ->{ 0.00 }
  field :whip, type: Float, default: ->{ 0.00 }
  field :strikeouts, type: Integer, default: ->{ 0 }
  field :saves, type: Integer, default: ->{ 0 }
  field :removed, type: Array

  def average_f
    ("%0.3f" % average).sub!(/^0/, "")
  end
  def era_f
    "%0.2f" % era
  end
  def whip_f
    "%0.2f" % whip
  end
end
