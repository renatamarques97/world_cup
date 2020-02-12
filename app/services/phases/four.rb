module Phases
  class Four
    DEFAULT_GROUP_SIZE = 1
    LOOSERS_GROUP = 'K'
    WINNERS_GROUP = 'L'
    DEFAULT_GROUPS = [
      LOOSERS_GROUP,
      WINNERS_GROUP
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
      @next_matches ||= loosers.concat(winners.flat_map(&:first)).each_slice(2).to_a
    end

    def loosers
      return @loosers if defined?(@loosers)

      @loosers = previous_groups.map do |group|
        ranking = group_rankings[group.name]
        ranking.last[:id]
      end
    end

    def winners
      return @winners if defined?(@winners)

      @winners = previous_groups.map do |group|
        ranking = group_rankings[group.name]
        next_phase_teams = ranking.take(DEFAULT_GROUP_SIZE)
        next_phase_teams.map { |t| t[:id] }
      end
    end

    def group_rankings
      return @group_rankings if defined?(@group_rankings)

      @group_rankings = previous_groups.inject({}) do |acc, group|
        acc[group.name] = GroupRankingCalculator.new(group).perform
        acc
      end
    end

    def previous_groups
      @previous_groups ||= tournament.groups.where(name: ::Phases::Three::DEFAULT_GROUPS)
    end

    def tournament
      @tournament ||= Tournament.find(tournament_id)
    end
  end
end
