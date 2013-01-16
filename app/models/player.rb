class Player
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  field :name, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :positions, type: Array
  field :team, type: String
  field :team_abbreviation, type: String
  field :type, type: String

  rails_admin do
    list do
      sort_by :last_name
      field :first_name
      field :last_name
      field :positions do
        pretty_value do
          value.join(",")
        end
      end
      field :team
    end
  end
end
