# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'StatesTournamentController', type: :request do
  describe 'GET /api/states_tournament' do
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

    before do
      post '/api/tournaments', params: valid_teams
    end

    context 'get states_tournament successfully' do
      it 'get states_tournament with status code 200' do
        tournament_id = Tournament.last.id
        get '/api/states_tournament?tournament_id=' + tournament_id.to_s
        expect(response).to have_http_status(200)
      end
    end
  end
end
