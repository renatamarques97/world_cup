class Phase < ApplicationRecord
  has_many :matches, class_name: "Match"

  #arr.combination(2).to_a
end
