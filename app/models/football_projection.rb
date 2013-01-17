class FootballProjection
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  field :name, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :positions, type: Array
  field :team, type: String
  field :team_abbreviation, type: String
  field :rank, type: Integer
  field :games, type: Integer, default: ->{ 0 }
  field :qbr, type: Float, default: ->{ 0.0 }
  field :comp, type: Integer, default: ->{ 0 }
  field :att, type: Integer, default: ->{ 0 }
  field :pct, type: Float, default: ->{ 0.0 }
  field :touchdowns, type: Integer, default: ->{ 0 }
  field :blurb, type: String
  field :owner, type: String
  field :year, type: Integer
end
