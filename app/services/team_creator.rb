# frozen_string_literal: true

class TeamCreator
  attr_reader :teams_params

  def initialize(teams_params:)
    @teams_params = teams_params
  end

  def created?
    return false if teams_valid?

    teams_params.each_value do |team_name|
      group = incomplete_group
      team = Team.new(name: team_name, group_id: group.id)
      team.save
    end

    if teams_valid?
      match_creator = MatchCreator.new
      match_creator.create_matches_phase_one
      return true
    end

    Team.destroy_all
    false
  end

  private

  def teams_valid?
    Team.count == 12
  end

  def incomplete_group
    group = Group.all.sample

    while group.teams.count > 2
      group = Group.all.sample
    end

    group
  end
end
