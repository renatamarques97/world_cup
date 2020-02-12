class Group < ApplicationRecord
  belongs_to :tournament
  has_many :teams, dependent: :destroy
end
