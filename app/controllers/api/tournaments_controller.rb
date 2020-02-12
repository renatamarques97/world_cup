# frozen_string_literal: true

module Api
  class TournamentsController < ApplicationController
    def create
      creator = TournamentCreator.new(params: tournament_params)

      if creator.perform
        render json: {
          status: I18n.t('status.success'),
          message: I18n.t('team.new.valid')
        }, status: :ok
      else
        render json: {
          status: I18n.t('status.error'),
          message: I18n.t('team.new.invalid')
        }, status: :unprocessable_entity
      end
    end

    private

    def tournament_params
      params.require(:tournament).permit(teams: [:name])
    end
  end
end
