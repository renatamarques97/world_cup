# frozen_string_literal: true

class MatchCreator
  def create_matches_phase_one
    tournament = Tournament.first
    phase = Phase.first

    Group.all.each do |group|
      teams_id = group.teams.pluck(:id)
      teams_id_permutation = teams_id.combination(2).to_a

      teams_id_permutation.each do |teams|
        match = Match.new(played: false, phase_id: phase.id)
        match.team_a_id = teams.first
        match.team_b_id = teams.second

        match.save
      end
    end

    tournament.first
    tournament.save
  end
end
