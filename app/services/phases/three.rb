module Phases
  class Three
    DEFAULT_GROUP_SIZE = 1
    DEFAULT_GROUPS = [
      'I',
      'J',
    ]

    def initialize(tournament_id)
      @tournament_id =  tournament_id
    end

    def setup
      next_matches.each_with_index do |next_match, index|
        GroupMatchCreator.new(
          DEFAULT_GROUPS[index],
          [next_match],
          tournament
        ).perform
      end
    end

    private

    attr_reader :tournament_id

    def next_matches
      @next_matches ||= winners.flat_map(&:first).each_slice(2).to_a
    end

    def winners
      return @winners if defined?(@winners)

      @winners = previous_groups.map do |group|
        ranking = GroupRankingCalculator.new(group).perform
        next_phase_teams = ranking.take(DEFAULT_GROUP_SIZE)
        next_phase_teams.map { |t| t[:id] }
      end
    end

    def previous_groups
      @previous_groups ||= tournament.groups.where(name: ::Phases::Two::DEFAULT_GROUPS)
    end

    def tournament
      @tournament ||= Tournament.find(tournament_id)
    end
  end
end
