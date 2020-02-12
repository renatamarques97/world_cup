class AddColumnsToOverallRankings < ActiveRecord::Migration[6.0]
  def change
    add_reference :overall_rankings, :tournament, null: false, foreign_key: true, index: true
    add_reference :overall_rankings, :team, null: false, foreign_key: true, index: true
    add_column :overall_rankings, :position, :integer
  end
end
