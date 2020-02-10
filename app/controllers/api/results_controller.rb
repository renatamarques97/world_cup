# frozen_string_literal: true

module Api
  class ResultsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
      match_result = Result.new(match_result_params: match_result_params)

      if match_result.match_result
        render json: { status: I18n.t('status.success'),
                       message: I18n.t('team.new.valid') },
                       status: :ok
      else
        render json: { status: I18n.t('status.error'),
                       message: I18n.t('team.new.invalid') },
                       status: :unprocessable_entity
      end
    end

    private

    def match_result_params
      params.permit(
        :id,
        :team_a_goals,
        :team_b_goals,
        matches: [:id, :team_a_goals, :team_b_goals]
      )
    end
  end
end
