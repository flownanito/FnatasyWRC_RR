class FantasyLineup < ApplicationRecord
  belongs_to :user
  belongs_to :league
  belongs_to :rally
  belongs_to :car
  belongs_to :engineer
  belongs_to :sponsor

  validate :within_budget
  validates :rally_id, uniqueness: { scope: [:user_id, :league_id], message: "Ya has configurado un setup para este rally" }

  def drivers
    league.league_drivers.where(user_id: user.id).map(&:driver)
  end

  def calculate_cost
    (car&.price || 0) + (engineer&.price || 0)
  end

  private

  def within_budget
    member = league.league_members.find_by(user_id: user.id)
    if member && calculate_cost > member.budget
      errors.add(:base, "Excede tu presupuesto disponible en esta liga.")
    end
  end
end
