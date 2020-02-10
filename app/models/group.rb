class Group < ApplicationRecord
  belongs_to :tournament, class_name: 'Tournament'
  has_many :teams, class_name: 'Team'
  # has_many :group_rankings, class_name: 'GroupRanking'
end
