module Phases
  class Five
    INITIAL = 1
    
    def initialize(tournament_id)
      @tournament_id = tournament_id
    end

    def setup
      overall_rankings = FinalPhaseRankingCalculator.new(tournament).perform

      overall_rankings.each_with_index do |ranking, index|
        team = Team.find(ranking[:id])
        overall_ranking = team.overall_ranking
        overall_ranking.update!(position: index + INITIAL)
      end
    end

    private

    attr_reader :tournament_id

    def tournament
      @tournament ||= Tournament.find(tournament_id)
    end
  end
end
