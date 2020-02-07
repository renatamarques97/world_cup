module Api
  class TeamsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
      teams = Team.order('id desc')
      render json: { status: I18n.t('status.success'), message: I18n.t('messages.success') }, status: :ok
    end

    def create
      team = Team.new(team_params[:team])
      
      team_create = TeamCreator.new(team_params: team_params)
      if team.save
        render json: { status: I18n.t('status.success'), message: I18n.t('team.new.valid') }, status: :ok
      else
        render json: { status: I18n.t('status.error'), message: I18n.t('team.new.invalid') }, status: :unprocessable_entity
      end

    end

    private

    def team_params
      params.permit(team: [:name])
    end
  end
end
