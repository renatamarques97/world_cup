class CreateMatchResults < ActiveRecord::Migration[6.0]
  def change
    create_table :match_results do |t|
      t.string :result, null: false
      t.integer :goals, null: false
      t.references :team, null: false, foreign_key: { to_table: 'teams' }
      t.references :match, null: false, foreign_key: { to_table: 'matches' }

      t.timestamps
    end
  end
end
