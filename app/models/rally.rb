class Rally < ApplicationRecord
  enum surface: { gravel: 0, tarmac: 1, snow: 2 }
  enum status: { upcoming: 0, ongoing: 1, finished: 2 }
  
  has_many :stages
  has_many :official_driver_results
  has_many :fantasy_lineups
end
