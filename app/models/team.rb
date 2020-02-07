class Team < ApplicationRecord
  validates :name, presence: true

  belongs_to :group, class_name: "Group", required: false
  has_one :group_ranking, class_name: "GroupRanking"
  # has_many :matches, class_name: "Match"
  # has_many :match_results, class_name: "MatchResult"
end
