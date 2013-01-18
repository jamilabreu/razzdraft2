# encoding: utf-8
class BaseballProjection
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  belongs_to :baseball_team
  after_validation :fix_blurb

  field :name, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :positions, type: Array
  field :team, type: String
  field :team_abbreviation, type: String
  field :rank, type: Integer
  field :runs, type: Integer, default: ->{ 0 }
  field :homeruns, type: Integer, default: ->{ 0 }
  field :rbi, type: Integer, default: ->{ 0 }
  field :average, type: Float, default: ->{ 0.000 }
  field :steals, type: Integer, default: ->{ 0 }
  field :wins, type: Integer, default: ->{ 0 }
  field :losses, type: Integer, default: ->{ 0 }
  field :era, type: Float, default: ->{ 0.00 }
  field :whip, type: Float, default: ->{ 0.00 }
  field :strikeouts, type: Integer, default: ->{ 0 }
  field :saves, type: Integer, default: ->{ 0 }
  field :blurb, type: String
  field :owner, type: String
  field :sport, type: String
  field :year, type: Integer

  rails_admin do
    list do
      sort_by :rank
      field :name
      field :owner
      field :year
      field :rank
      field :runs
      field :homeruns
      field :rbi
      field :average
      field :steals
      field :wins
      field :losses
      field :strikeouts
      field :era
      field :whip
      field :saves
    end
  end

  def fix_blurb
    self.blurb = blurb.gsub(/<a href/, "<a target='_blank' href").gsub(/_/," ").gsub(/Ð/, " ").gsub(/Ó/,"'") if self.blurb
  end
  def average_f
    ("%0.3f" % average).sub!(/^0/, "")
  end
  def era_f
    "%0.2f" % era
  end
  def whip_f
    "%0.2f" % whip
  end
  def position
    positions.first
  end
end
