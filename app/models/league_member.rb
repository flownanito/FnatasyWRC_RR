class LeagueMember < ApplicationRecord
  belongs_to :user
  belongs_to :league

  validate :max_players_limit, on: :create

  private

  def max_players_limit
    if league.users.count >= 5
      errors.add(:base, "This league already has the maximum of 5 players.")
    end
  end
end
