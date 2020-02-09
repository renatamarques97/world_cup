# frozen_string_literal: true

class Result
  attr_reader :team_a, :team_b

  def initialize(match_result_params:)
    @team_a = match_result_params[:team_a]
    @team_b = match_result_params[:team_b]
  end

  def match_result
    match = Match.where(team_a_id: team_a[:id], team_b_id: team_b[:id]).first

    return false if match.nil? || match.played

    result_team_a = nil
    result_team_b = nil

    if team_a[:goals] > team_b[:goals]
      result_team_a = 'win'
      result_team_b = 'defeat'
    elsif team_a[:goals] < team_b[:goals]
      result_team_a = 'defeat'
      result_team_b = 'win'
    else
      result_team_a = 'draw'
      result_team_b = 'draw'
    end

    match_result_team_a = MatchResult.new(result: result_team_a,
                                          goals: team_a[:goals],
                                          team_id: match.team_a_id,
                                          match_id: match.id)
    match_result_team_b = MatchResult.new(result: result_team_b,
                                          goals: team_b[:goals],
                                          team_id: match.team_b_id,
                                          match_id: match.id)
    match_result_team_a.save
    match_result_team_b.save

    match.played = true
    match.save
  end
end
