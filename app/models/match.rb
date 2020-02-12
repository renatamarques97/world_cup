class Match < ApplicationRecord
  has_many :match_results, dependent: :destroy

  belongs_to :team_a, class_name: 'Team'
  belongs_to :team_b, class_name: 'Team'
  belongs_to :tournament
end
