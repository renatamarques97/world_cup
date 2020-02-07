class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.references :group, null: true, foreign_key: { to_table: 'groups' }

      t.timestamps
    end
  end
end