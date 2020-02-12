class AddTournamentToTeams < ActiveRecord::Migration[6.0]
  def change
    add_reference :teams, :tournament, foreign_key: true, index: true
  end
end
