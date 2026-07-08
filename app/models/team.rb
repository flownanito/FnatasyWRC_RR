class Team < ApplicationRecord
  has_many :drivers
  has_many :cars
  belongs_to :user, optional: true
end
