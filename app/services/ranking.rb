class Ranking
  def ranking
    teams = Team.all
    teams_point = []

    teams.each do |team|
      team_goals = team.match_results.pluck(:goals).sum
      results = result_format(team)

      teams_point += [id: team.id,
                      total_goals: team_goals,
                      results: results]
    end

    teams_point.sort_by { |team_point| [team_point[:results][:win], team_point[:total_goals]] }.reverse
  end

  private

  def result_format(team)
    results = { win: 0, defeat: 0, draw: 0 }

    team.match_results.pluck(:result).each do |result|
      if result == "win"
        results[:win] += 1
      elsif result == "defeat"
        results[:defeat] += 1
      else
        results[:draw] += 1
      end
    end

    results
  end

end
