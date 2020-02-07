class CreateGroupRankings < ActiveRecord::Migration[6.0]
  def change
    create_table :group_rankings do |t|
      t.references :group, null: false, foreign_key: { to_table: 'groups' }
      t.references :team, null: false, foreign_key: { to_table: 'teams' }

      t.timestamps
    end
  end
end
