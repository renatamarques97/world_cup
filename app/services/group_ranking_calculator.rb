class GroupRankingCalculator
  attr_reader :group

  delegate :teams, to: :group

  WIN  = 'win'
  DRAW = 'draw'

  def initialize(group)
    @group = group
  end

  def perform
    ranked_teams = []

    teams.each do |team|
      match_results = team.match_results
      total_goals = match_results.pluck(:goals).sum

      ranked_teams << {
        id: team.id,
        points: points(match_results),
        goals: total_goals
      }
    end

    ranked_teams.sort_by { |team| [team[:points], team[:goals]] }.reverse
  end

  private

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
