# frozen_string_literal: true

module Api
  class TeamsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
      teams = Team.order('id desc')
      render json: { status: I18n.t('status.success'),
                     message: I18n.t('messages.success'), data: teams
                    }, status: :ok
    end

    def create
      team = TeamCreator.new(teams_params: teams_params)

      if team.created?
        render json: { status: I18n.t('status.success'),
                       message: I18n.t('team.new.valid')
                      }, status: :ok
      else
        render json: { status: I18n.t('status.error'),
                       message: I18n.t('team.new.invalid')
                      }, status: :unprocessable_entity
      end
    end

    private

    def teams_params
      params.permit(:team1, :team2, :team3,
                    :team4, :team5, :team6,
                    :team7, :team8, :team9,
                    :team10, :team11, :team12)
    end
  end
end
