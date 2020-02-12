# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'RankingsController', type: :request do
  describe 'GET /api/rankings' do
    context 'get rankings successfully' do
      it 'get rankings with status code 200' do
        get '/api/rankings'
        expect(response).to have_http_status(200)
      end
    end
  end
end
