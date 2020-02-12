# frozen_string_literal: true

class StateTournament
  def initialize(tournament_id)
    @tournament_id = tournament_id
  end

  def perform
    {
      id: tournament.id,
      name: tournament.name,
      state: tournament.state,
      teams: tournament.teams.select(:id, :name),
      next_matches: matches[false],
      played_matches: matches[true]
    }
  end

  private

  attr_reader :tournament_id

  def tournament
    @tournament ||= Tournament.find(tournament_id)
  end

  def matches
    @matches ||= Match.where(
      phase: tournament.state,
      tournament: tournament.id
    ).select(*match_attributes)
    .group_by(&:played)
  end

  def match_attributes
    [
      :id,
      :played,
      :team_a_id,
      :team_b_id,
      :phase
    ]
  end
end
