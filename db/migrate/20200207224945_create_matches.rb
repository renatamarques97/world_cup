class CreateMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :matches do |t|
      t.boolean :played
      t.references :team_a, null: false, foreign_key: { to_table: 'teams' }
      t.references :team_b, null: false, foreign_key: { to_table: 'teams' }

      t.timestamps
    end
  end
end
