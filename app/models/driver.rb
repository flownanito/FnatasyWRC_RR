class Driver < ApplicationRecord
  belongs_to :team, optional: true
  enum category: { rally1: 0, rally2: 1, wrc3: 2 }
  enum participation: { full_time: 0, part_time: 1 }
  has_many :official_driver_results
  has_many :league_drivers
end
