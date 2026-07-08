class LeagueDriver < ApplicationRecord
  belongs_to :league
  belongs_to :driver
  belongs_to :user, optional: true
end
