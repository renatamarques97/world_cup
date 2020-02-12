module Phases
  class Two
    DEFAULT_GROUP_SIZE = 2
    DEFAULT_GROUPS = [
      'E',
      'F',
      'G',
      'H'
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
      return @next_matches if defined?(@next_matches)
      new_matches = []

      winners.each_slice(DEFAULT_GROUP_SIZE).to_a.each do |groups|
        first_team  = groups[0][0]
        second_team = groups[1][1]
        third_team  = groups[0][1]
        forth_team  = groups[1][0]
        new_matches << [first_team, second_team]
        new_matches << [third_team, forth_team]
      end

      @next_matches = new_matches
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
      @previous_groups ||= tournament.groups.where(name: ::Phases::One::DEFAULT_GROUPS)
    end

    def tournament
      @tournament ||= Tournament.find(tournament_id)
    end
  end
end
