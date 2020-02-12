require 'aasm'

class Tournament < ActiveRecord::Base
  include AASM

  has_many :groups, dependent: :destroy
  has_many :teams, dependent: :destroy
  has_many :overall_rankings, dependent: :destroy
  has_many :matches, dependent: :destroy

  aasm.attribute_name :state

  aasm column: 'state' do
    state :none, initial: true
    state :first, :second, :semifinal, :final, :done

    event :first, after: :setup_phase_one do
      transitions from: :none, to: :first
    end

    event :second, after: :setup_phase_two do
      transitions from: :first, to: :second
    end

    event :semifinal, after: :setup_phase_three do
      transitions from: :second, to: :semifinal
    end

    event :final, after: :setup_phase_four do
      transitions from: :semifinal, to: :final
    end

    event :done, after: :finish_tournament do
      transitions from: :final, to: :done
    end
  end

  def setup_phase_one
    Phases::One.new(id).setup
  end

  def setup_phase_two
    Phases::Two.new(id).setup
  end

  def setup_phase_three
    Phases::Three.new(id).setup
  end

  def setup_phase_four
    Phases::Four.new(id).setup
  end

  def finish_tournament
    Phases::Five.new(id).setup
  end

  def next_phase
    case state
    when 'none'
      self.first!
    when 'first'
      self.second!
    when 'second'
      self.semifinal!
    when 'semifinal'
      self.final!
    when 'final'
      self.done!
    else
      'No transitions available'
    end
  end
end
