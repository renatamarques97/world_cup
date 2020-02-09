class AddTournamentToGroup < ActiveRecord::Migration[6.0]
  def change
    add_reference :groups, :tournament, null: false, foreign_key: { to_table: 'tournaments' }
  end
end
