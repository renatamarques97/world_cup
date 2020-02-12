class Team < ApplicationRecord
  validates :name, presence: true

  belongs_to :group, required: false
  belongs_to :tournament, required: false

  has_many :match_results, dependent: :destroy
  has_one :overall_ranking, dependent: :destroy
end
