class FinalPhaseRankingCalculator
  attr_reader :tournament

  delegate :teams, to: :tournament

  DEFEAT = 'defeat'
  WIN    = 'win'
  DRAW   = 'draw'

  def initialize(tournament)
    @tournament = tournament
  end

  def perform
    ranked_teams = []

    teams.each do |team|
      match_results = team.match_results
      total_goals = match_results.pluck(:goals).sum

      ranked_teams << {
        id: team.id,
        points: points(match_results),
        defeats: defeats(match_results),
        goals: total_goals
      }
    end

    ranked_teams.sort_by { |team| [team[:points], team[:defeats], team[:goals]] }.reverse
  end

  private

  def defeats(match_result)
    @defeats ||= match_result.where(result: DEFEAT).count * -1
  end

  def points(match_results)
    match_results.inject(0) do |acc, match_result|
      case match_result.result
      when WIN
        acc += 3
      when DRAW
        acc += 1
      end
      acc
    end
  end
end
