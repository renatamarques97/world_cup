class Match < ApplicationRecord
  has_many :match_results, class_name: 'MatchResult'
  belongs_to :team_a, class_name: 'Team'
  belongs_to :team_b, class_name: 'Team'
  belongs_to :phase, class_name: 'Phase'

  def played?
  end
end
