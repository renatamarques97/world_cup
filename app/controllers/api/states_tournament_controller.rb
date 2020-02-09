# frozen_string_literal: true

module Api
  class StatesTournamentController < ApplicationController
    def index
      state_tournament = StateTournament.new
      tournaments = state_tournament.state_tournament

      render json: { status: I18n.t('status.success'),
                     message: I18n.t('team.new.valid'),
                     data: tournaments }, status: :ok
    end
  end
end