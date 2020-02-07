module Api
  class TournamentsController < ApplicationController
    def index
      render json: {status: I18n.t('status.success'), message: I18n.t('team.new.valid')}, status: :ok
    end

    def show
    end
  end
end