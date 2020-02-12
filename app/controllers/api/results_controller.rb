# frozen_string_literal: true

module Api
  class ResultsController < ApplicationController
    def create
      match_result = Result.new(
        tournament_id: match_result_params[:id],
        matches_results: match_result_params[:matches]
      )

      if match_result.perform
        render json: {
          status: I18n.t('status.success'),
          message: I18n.t('result.new.valid')
        }, status: :ok
      else
        render json: {
          status: I18n.t('status.error'),
          message: I18n.t('result.new.invalid')
        }, status: :unprocessable_entity
      end
    end

    private

    def match_result_params
      params.require(:tournament).permit(
        :id,
        matches: [:id, :team_a_goals, :team_b_goals]
      )
    end
  end
end
