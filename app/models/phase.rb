class Phase < ApplicationRecord
  belongs_to :tournament, class_name: 'Tournament'
  has_many :matches, class_name: 'Match'

  # arr.combination(2).to_a
end
