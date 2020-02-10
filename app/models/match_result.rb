class MatchResult < ApplicationRecord
  belongs_to :match, class_name: 'Match'
  belongs_to :team, class_name: 'Team'
end
