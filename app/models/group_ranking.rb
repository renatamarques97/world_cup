class GroupRanking < ApplicationRecord
  belongs_to :group, class_name: "Group"
  belongs_to :team, class_name: "Team"
end
