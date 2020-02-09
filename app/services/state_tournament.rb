# frozen_string_literal: true

class StateTournament
  def state_tournament
    all_tournaments = Tournament.all

    tournaments = []
    all_tournaments.each do |tournament|
      teams = []

      tournament.groups.each do |group|
        group.teams.each do |team|
          teams += [id: team.id, name: team.name]
        end
      end

      tournaments += outcome(tournament, teams)
    end

    tournaments
  end

  private

  def outcome(tournament, teams)
    prettier_tournament(tournament, teams)
  end

  def matches_played(phases_tournament_id)
    matches_played = Match.where(played: true, phase_id: phases_tournament_id)
    prettier_matches(matches_played)
  end

  def matches_not_played(phases_tournament_id)
    matches_not_played = Match.where(played: false, phase_id: phases_tournament_id)
    prettier_matches(matches_not_played)
  end

  def prettier_matches(matches)
    prettier_matches = []
    matches.each do |match|
      prettier_matches += [id: match.id, played: match.played,
                            team_a: match.team_a_id, team_b: match.team_b_id,
                            phase: match.phase_id]
    end

    prettier_matches
  end

  def prettier_tournament(tournament, teams)
    phases_tournament_id = tournament.phases.pluck(:id)

    next_matches = matches_not_played(phases_tournament_id)
    played_matches = matches_played(phases_tournament_id)

    [id: tournament.id, name: tournament.name, state: tournament.state,
      teams: teams, next_matches: next_matches, played_matches: played_matches]
  end
end
