class Match < ApplicationRecord
  has_many :match_results, class_name: "MatchResult"
  has_one :team, class_name: "Team", foreign_key: "team_a_id", as: :team_a
  has_one :team, class_name: "Team", foreign_key: "team_b_id", as: :team_b

  def played?
  end
end
