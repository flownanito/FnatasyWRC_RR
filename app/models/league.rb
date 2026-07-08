class League < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :league_members
  has_many :users, through: :league_members
  has_many :league_drivers, dependent: :destroy
  has_many :fantasy_lineups, dependent: :destroy
  
  before_create :generate_code
  after_create :initialize_market

  private

  def generate_code
    self.code = SecureRandom.hex(4).upcase
  end

  def initialize_market
    Driver.all.each do |driver|
      league_drivers.create!(driver: driver, user: nil, release_clause: nil)
    end
  end
end
