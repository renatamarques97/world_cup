# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'TournamentsController', type: :request do
  describe 'POST /api/tournaments' do
    context 'post tournaments successfully' do
      let(:valid_teams) {{
        tournament: {
          teams: [
            { name: FFaker::Address.country },
            { name: FFaker::Address.country },
            { name: FFaker::Address.country },
            { name: FFaker::Address.country },
            { name: FFaker::Address.country },
            { name: FFaker::Address.country },
            { name: FFaker::Address.country },
            { name: FFaker::Address.country },
            { name: FFaker::Address.country },
            { name: FFaker::Address.country },
            { name: FFaker::Address.country },
            { name: FFaker::Address.country }
          ]
        }
      }}

      it 'post tournaments with status code 200' do
        post '/api/tournaments', params: valid_teams
        expect(response).to have_http_status(200)
      end

      it 'post tournaments successfully' do
        expect{
          post '/api/tournaments', params: valid_teams
        }.to change(Tournament, :count).by (1)
      end
    end

    context 'post tournaments with error' do
      let(:invalid_teams) {{
        "tournament": {
          "teams": [
            { name: FFaker::Address.country },
            { name: FFaker::Address.country },
            { name: FFaker::Address.country },
            { name: FFaker::Address.country },
            { name: FFaker::Address.country },
            { name: FFaker::Address.country },
            { name: FFaker::Address.country },
            { name: FFaker::Address.country },
            { name: FFaker::Address.country },
            { name: FFaker::Address.country },
            { name: FFaker::Address.country }
          ]
        }
      }}

      it 'post tournaments with status code 422' do
        post '/api/tournaments', params: invalid_teams
        expect(response).to have_http_status(422)
      end

      it 'post tournaments with error' do
        expect{
          post '/api/tournaments', params: invalid_teams
        }.not_to change(Tournament, :count)
      end
    end
  end
end
