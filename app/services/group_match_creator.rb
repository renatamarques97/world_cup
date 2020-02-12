# frozen_string_literal: true

class GroupMatchCreator
  attr_reader :group_name, :next_matches

  def initialize(group_name, next_matches, tournament)
    @group_name = group_name
    @next_matches = next_matches
    @tournament = tournament
  end

  def perform
    next_matches.each.with_index do |next_match, index|
      Team.update(
        [
          next_match.first,
          next_match.last
        ],
        [
          { group_id: group.id },
          { group_id: group.id }
        ]
      )

      match = ::Match.new(
        team_a_id: next_match.first,
        team_b_id: next_match.last,
        tournament_id: tournament.id,
        played: false,
        phase: tournament.state
      )

      match.save!
    end
  end

  private

  attr_reader :tournament

  def group
    @group ||= Group.create!(name: group_name, tournament_id: tournament.id)
  end
end
