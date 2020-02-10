module Api
  class RankingsController < ApplicationController
    def index
      ranking = Ranking.new

      render json: { status: I18n.t('status.success'),
                      message: I18n.t('team.new.valid'),
                      data: ranking.ranking }, status: :ok
    end
  end
end