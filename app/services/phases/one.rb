module Phases
  class One
    DEFAULT_GROUP_SIZE = 3
    DEFAULT_GROUPS = [
      'A',
      'B',
      'C',
      'D'
    ]

    def initialize(tournament_id)
      @tournament_id =  tournament_id
    end

    def setup
      next_matches.each_with_index do |next_match, index|
        GroupMatchCreator.new(
          DEFAULT_GROUPS[index],
          next_match,
          tournament
        ).perform
      end
    end

    private

    attr_reader :tournament_id

    def next_matches
      @next_matches ||= grouped_teams.map { |group| group.map(&:id).combination(2).to_a }
    end

    def grouped_teams
      @grouped_teams ||= shuffled_teams.each_slice(DEFAULT_GROUP_SIZE).to_a
    end


    def shuffled_teams
      @shuffled_teams ||= teams.shuffle
    end

    def teams
      @team ||= tournament.teams
    end

    def tournament
      @tournament ||= Tournament.find(tournament_id)
    end
  end
end
