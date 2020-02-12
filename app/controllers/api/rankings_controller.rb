# frozen_string_literal: true

module Api
  class RankingsController < ApplicationController
    def index
      ranking = OverallRanking.where(tournament_id: params[:tournament_id]).order("position")

      results = ranking.map do |p|
        {
          position: p.position,
          name: p.team.name,
          team_id: p.team.id
        }
      end

      render json: {
        status: I18n.t('status.success'),
        message: I18n.t('ranking.new.valid'),
        data: results
      }, status: :ok
    end
  end
end
