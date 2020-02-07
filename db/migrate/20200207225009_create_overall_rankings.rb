class CreateOverallRankings < ActiveRecord::Migration[6.0]
  def change
    create_table :overall_rankings do |t|

      t.timestamps
    end
  end
end
