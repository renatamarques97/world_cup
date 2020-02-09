class AddTournamentToPhases < ActiveRecord::Migration[6.0]
  def change
    add_reference :phases, :tournament, null: false, foreign_key: { to_table: 'tournaments' }
  end
end
