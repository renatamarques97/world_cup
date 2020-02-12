require 'rails_helper'

RSpec.describe Group, type: :model do
  describe 'validations' do
    it { should belong_to(:tournament) }
  end

  context "Valid Group" do
    let(:valid_teams) {{
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
    }}

    before do
      creator = TournamentCreator.new(params: valid_teams)
      creator.perform
    end

    it 'It is a valid group' do
      tournament = Tournament.last
      group = Group.new(tournament_id: tournament.id, name: FFaker::Name)

      expect(group.valid?).to be_truthy
    end

  end
end
