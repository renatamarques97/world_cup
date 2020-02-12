# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ResultsController', type: :request do
  describe 'POST /api/results' do
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

    let(:tournament) { Tournament.last }

    before do
      post '/api/tournaments', params: valid_teams
    end

    context 'post results successfully' do
      let(:match) { tournament.matches.sample }

      let(:valid_result) {
        {
          tournament: {
            id: tournament.id,
            matches: [
              {
                id: match.id,
                team_a_goals: 7,
                team_b_goals: 1
              }
            ]
          }
        }
      }

      it 'post results with status code 200' do
        post '/api/results', params: valid_result
        expect(response).to have_http_status(200)
      end
    end

    context 'post result with error' do
      let(:invalid_result) {
        {
          "tournament": {
            "id": tournament.id,
            "matches": [
              {
                "id": rand(-10..0),
                "team_a_goals": 7,
                "team_b_goals": 1
              }
            ]
          }
        }
      }

      it 'post results with error' do
        post '/api/results', params: invalid_result
        expect(response).to have_http_status(422)
      end
    end
  end
end
