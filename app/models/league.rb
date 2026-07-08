class League < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :league_members
  has_many :users, through: :league_members
  has_many :league_drivers, dependent: :destroy
  has_many :fantasy_lineups, dependent: :destroy
  
  before_create :generate_code
  after_create :initialize_market
  
  validate :creation_limit, on: :create

  private

  def creation_limit
    if owner && owner.owned_leagues.count >= 3
      errors.add(:base, "Has alcanzado el límite de 3 ligas gratuitas. Adquiere el pase Premium para gestionar más equipos.")
    end
  end

  def generate_code
    self.code = SecureRandom.hex(4).upcase
  end

  def initialize_market
    Driver.all.each do |driver|
      league_drivers.create!(driver: driver, user: nil, release_clause: nil)
    end
  end
end
