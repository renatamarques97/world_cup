require 'aasm'

class Tournament < ActiveRecord::Base
  include AASM

  has_many :groups, class_name: 'Group'
  has_many :phases, class_name: 'Phase'

  aasm.attribute_name :state
  aasm column: 'state' do
    state :none, initial: true
    state :first, :second, :semifinal, :final

    event :first do
      transitions from: :none, to: :first
    end

    event :second do
      transitions from: :first, to: :second
    end

    event :semifinal do
      transitions from: :second, to: :semifinal
    end

    event :final do
      transitions from: :semifinal, to: :final
    end
  end
end
