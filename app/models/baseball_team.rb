class BaseballTeam
  include Mongoid::Document
  belongs_to :user
  has_many :baseball_projections

  field :league_type, type: String
  field :league_size, type: Integer
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
  field :"BENCH", type: Array

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
  field :bench_max

  field :plate_appearances, type: Integer, default: ->{ 0 }
  field :at_bats, type: Integer, default: ->{ 0 }
  field :hits, type: Integer, default: ->{ 0 }
  field :times_on_base, type: Integer, default: ->{ 0 }
  field :runs, type: Integer, default: ->{ 0 }
  field :homeruns, type: Integer, default: ->{ 0 }
  field :rbi, type: Integer, default: ->{ 0 }
  field :steals, type: Integer, default: ->{ 0 }
  field :average, type: Float, default: ->{ 0.000 }
  field :obp, type: Float, default: ->{ 0.000 }

  field :innings_pitched, type: Integer, default: ->{ 0 }
  field :earned_runs, type: Float, default: ->{ 0.000 }
  field :basemen_allowed, type: Float, default: ->{ 0.000 }
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
  def obp_f
    ("%0.3f" % obp).sub!(/^0/, "")
  end
  def era_f
    "%0.2f" % era
  end
  def whip_f
    "%0.2f" % whip
  end
  def players_max
    catcher_max.to_i + first_base_max.to_i + second_base_max.to_i + shortstop_max.to_i + third_base_max.to_i + outfield_max.to_i + util_max.to_i + starter_max.to_i + reliever_max.to_i + pitcher_max.to_i + middle_infielder_max.to_i + corner_infielder_max.to_i + bench_max.to_i
  end
  def goal(stat)
    if league_type == "espn"
      if stat == :runs
        league_size == 10 ? 1083 : league_size == 12 ? 1045 : league_size == 14 ? 1014 : league_size == 15 ? 999 : 982
      elsif stat == :homeruns
        league_size == 10 ? 270 : league_size == 12 ? 261 : league_size == 14 ? 253 : league_size == 15 ? 247 : 240
      elsif stat == :rbi
        league_size == 10 ? 1034 : league_size == 12 ? 1008 : league_size == 14 ? 979 : league_size == 15 ? 961 : 941
      elsif stat == :steals
        league_size == 10 ? 212 : league_size == 12 ? 189 : league_size == 14 ? 176 : league_size == 15 ? 171 : 169
      elsif stat == :average
        league_size == 10 ? 0.269 : league_size == 12 ? 0.267 : league_size == 14 ? 0.265 : league_size == 15 ? 0.264 : 0.264
      elsif stat == :wins
        league_size == 10 ? 103 : league_size == 12 ? 100 : league_size == 14 ? 98 : league_size == 15 ? 97 : 96
      elsif stat == :saves
        league_size == 10 ? 105 : league_size == 12 ? 92 : league_size == 14 ? 81 : league_size == 15 ? 72 : 73
      elsif stat == :strikeouts
        league_size == 10 ? 1261 : league_size == 12 ? 1330 : league_size == 14 ? 1188 : league_size == 15 ? 1170 : 1158
      elsif stat == :era
        league_size == 10 ? 3.37 : league_size == 12 ? 3.44 : league_size == 14 ? 3.49 : league_size == 15 ? 3.51 : 3.54
      elsif stat == :whip
        league_size == 10 ? 1.23 : league_size == 12 ? 1.24 : league_size == 14 ? 1.25 : league_size == 15 ? 1.25 : 1.26
      end
    else
      if stat == :runs
        league_size == 10 ? 856 : league_size == 12 ? 838 : league_size == 14 ? 817 : league_size == 15 ? 805 : 794
      elsif stat == :homeruns
        league_size == 10 ? 220 : league_size == 12 ? 211 : league_size == 14 ? 202 : league_size == 15 ? 200 : 198
      elsif stat == :rbi
        league_size == 10 ? 827 : league_size == 12 ? 804 : league_size == 14 ? 783 : league_size == 15 ? 774 : 785
      elsif stat == :steals
        league_size == 10 ? 175 : league_size == 12 ? 163 : league_size == 14 ? 154 : league_size == 15 ? 148 : 143
      elsif stat == :average
        league_size == 10 ? 0.272 : league_size == 12 ? 0.270 : league_size == 14 ? 0.269 : league_size == 15 ? 0.268 : 0.267
      elsif stat == :wins
        league_size == 10 ? 103 : league_size == 12 ? 100 : league_size == 14 ? 95 : league_size == 15 ? 97 : 96
      elsif stat == :saves
        league_size == 10 ? 105 : league_size == 12 ? 92 : league_size == 14 ? 81 : league_size == 15 ? 72 : 73
      elsif stat == :strikeouts
        league_size == 10 ? 1261 : league_size == 12 ? 1330 : league_size == 14 ? 1188 : league_size == 15 ? 1170 : 1158
      elsif stat == :era
        league_size == 10 ? 3.37 : league_size == 12 ? 3.44 : league_size == 14 ? 3.49 : league_size == 15 ? 3.51 : 3.54
      elsif stat == :whip
        league_size == 10 ? 1.23 : league_size == 12 ? 1.24 : league_size == 14 ? 1.25 : league_size == 15 ? 1.25 : 1.26
      end
    end
  end
  def percent_goal(stat)
    if stat == :era || stat == :whip
      percentage = self.send(stat) == 0 ? 0 : self.goal(stat) / self.send(stat)
    else
      percentage = self.send(stat).to_f / self.goal(stat)
    end
    percentage == 0 ? "-" : "#{(percentage*100).round(0)}%"
  end
end
