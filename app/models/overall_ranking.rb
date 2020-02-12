class OverallRanking < ApplicationRecord
  belongs_to :tournament
  belongs_to :team
end
