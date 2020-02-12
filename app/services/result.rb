# frozen_string_literal: true

class Result
  attr_reader :matches_results, :tournament_id

  DEFEAT = 'defeat'
  WIN    = 'win'
  DRAW   = 'draw'

  def initialize(tournament_id:, matches_results:)
    @tournament_id = tournament_id
    @matches_results = matches_results
  end

  def perform
    return false unless matches_current_in_phase?
    matches_results.map do |match_result|
      ActiveRecord::Base.transaction do
        match = matches.find(match_result[:id])
        next if match.played
        result = game_result(match_result)
        match_result_team_a = MatchResult.create!(
          result: result[:team_a],
          goals: match_result[:team_a_goals],
          team_id: match.team_a_id,
          match_id: match.id
        )
        match_result_team_b = MatchResult.create!(
          result: result[:team_b],
          goals: match_result[:team_b_goals],
          team_id: match.team_b_id,
          match_id: match.id
        )

        match.update!(played: true)
      end
    end

    if all_matches_played?
      tournament.next_phase
    end
    true
  end

  private

  def all_matches_played?
    matches.reload.pluck(:played).uniq == [true]
  end

  def game_result(match_result)
    team_a_goals = match_result[:team_a_goals]
    team_b_goals = match_result[:team_b_goals]

    if team_a_goals < team_b_goals
      { team_a: DEFEAT, team_b: WIN }
    elsif team_a_goals > team_b_goals
      { team_a: WIN, team_b: DEFEAT }
    else
      { team_a: DRAW, team_b: DRAW }
    end
  end

  def matches_current_in_phase?
    matches_ids.all? do |match_id|
      tournament_matches_ids.include?(match_id.to_i)
    end
  end

  def tournament_matches_ids
    @tournament_matches_ids ||= matches.pluck(:id)
  end

  def matches
    @match ||= Match.where(
      tournament_id: tournament_id,
      phase: tournament.state
    )
  end

  def matches_ids
    @matches_ids ||= matches_results.map { |match| match[:id] }
  end

  def tournament
    @tournament ||= Tournament.find(tournament_id)
  end
end
