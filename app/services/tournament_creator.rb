# frozen_string_literal: true

class TournamentCreator
  TOURNAMENT_TEAM_COUNT = 12

  attr_reader :params

  def initialize(params:)
    @params = params
  end

  def perform
    return false if invalid?

    ActiveRecord::Base.transaction do
      create_teams

      tournament.first!

      setup_ranking
    end
  end

  def errors
    if invalid?
      "Invalid team count, please submit #{TOURNAMENT_TEAM_COUNT} teams."
    end
  end

  private

  def setup_ranking
    tournament.teams.each do |team|
      OverallRanking.create!(team: team, tournament: tournament, position: TOURNAMENT_TEAM_COUNT)
    end
  end

  def tournament
    @tournament ||= Tournament.create!
  end

  def create_teams
    teams.each do |team|
      Team.create!(name: team[:name], tournament_id: tournament.id)
    end
  end

  def teams
    @teams ||= params[:teams]
  end

  def invalid?
    teams.count != TOURNAMENT_TEAM_COUNT || Tournament.where.not(state: :done).any?
  end
end
