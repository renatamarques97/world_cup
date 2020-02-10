# frozen_string_literal: true

class Result
  attr_reader :match_result_params

  def initialize(match_result_params:)
    @match_result_params = match_result_params
  end

  def match_result
    return match_result_single(match_result_params) if match_result_params[:matches].nil?

    match_result_list
  end

  def match_result_single(result_params)
    match = Match.find(result_params[:id])

    return false if match.nil? || match.played || !current_phase?(match)

    team_a_goals = result_params[:team_a_goals]
    team_b_goals = result_params[:team_b_goals]

    created_matches_results(match, team_a_goals, team_b_goals)
  end

  def match_result_list
    match_result_params[:matches].each do |result_params|
      match_result_single(result_params)
    end
  end

  def created_matches_results(match, team_a_goals, team_b_goals)
    result_game = result_game(team_a_goals, team_b_goals)
    result_team_a = result_game.first
    result_team_b = result_game.second

    match_result_team_a = MatchResult.new(result: result_team_a,
                                          goals: team_a_goals,
                                          team_id: match.team_a_id,
                                          match_id: match.id)
    match_result_team_b = MatchResult.new(result: result_team_b,
                                          goals: team_b_goals,
                                          team_id: match.team_b_id,
                                          match_id: match.id)
    match_result_team_a.save
    match_result_team_b.save

    match.played = true
    match.save
  end

  private

  def current_phase?(match)
    match.phase[:name] == Tournament.find(match.phase_id).state
  end

  def result_game(team_a_goals, team_b_goals)
    if team_a_goals > team_b_goals
      ['win', 'defeat']
    elsif team_a_goals < team_b_goals
      ['defeat', 'win']
    else
      ['draw', 'draw']
    end
  end

end
