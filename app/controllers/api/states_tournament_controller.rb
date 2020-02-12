# frozen_string_literal: true

module Api
  class StatesTournamentController < ApplicationController
    def index
      state_tournament = StateTournament.new(params[:tournament_id])

      render json: {
        status: I18n.t('status.success'),
        message: I18n.t('states_tournament.new.valid'),
        data: state_tournament.perform
      }, status: :ok
    end
  end
end
