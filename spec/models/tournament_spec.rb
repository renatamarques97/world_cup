require 'rails_helper'

RSpec.describe Tournament, type: :model do
  describe '#next_phase' do
    context '#aasm' do
      it 'when state is none' do
        expect(subject.state).to eq("none")
      end

      it 'when state is first' do
        subject.next_phase
        expect(subject.state).to eq("first")
      end

      it 'when state is second' do
        subject.next_phase
        subject.next_phase
        expect(subject.state).to eq("second")
      end

      it 'when state is semifinal' do
        subject.next_phase
        subject.next_phase
        subject.next_phase
        expect(subject.state).to eq("semifinal")
      end

      it 'when state is final' do
        subject.next_phase
        subject.next_phase
        subject.next_phase
        subject.next_phase
        expect(subject.state).to eq("final")
      end

      it 'when state is done' do
        subject.next_phase
        subject.next_phase
        subject.next_phase
        subject.next_phase
        subject.next_phase
        expect(subject.state).to eq("done")
      end
    end
  end
end
