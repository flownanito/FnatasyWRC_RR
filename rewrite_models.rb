require 'fileutils'

def rewrite_model(name, content)
  path = "app/models/#{name}.rb"
  File.write(path, content)
end

rewrite_model("user", <<~RUBY
class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :league_members
  has_many :leagues, through: :league_members
  has_many :owned_leagues, class_name: "League", foreign_key: "owner_id"
  has_many :fantasy_lineups
end
RUBY
)

rewrite_model("league", <<~RUBY
class League < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :league_members
  has_many :users, through: :league_members
  
  before_create :generate_code

  private
  def generate_code
    self.code = SecureRandom.hex(4).upcase
  end
end
RUBY
)

rewrite_model("driver", <<~RUBY
class Driver < ApplicationRecord
  enum category: { rally1: 0, rally2: 1, wrc3: 2 }
  has_many :official_driver_results
end
RUBY
)

rewrite_model("engineer", <<~RUBY
class Engineer < ApplicationRecord
  enum specialty: { engine: 0, aero: 1, suspension: 2, mechanics: 3 }
end
RUBY
)

rewrite_model("rally", <<~RUBY
class Rally < ApplicationRecord
  enum surface: { gravel: 0, tarmac: 1, snow: 2 }
  enum status: { upcoming: 0, ongoing: 1, finished: 2 }
  
  has_many :stages
  has_many :official_driver_results
  has_many :fantasy_lineups
end
RUBY
)

rewrite_model("fantasy_lineup", <<~RUBY
class FantasyLineup < ApplicationRecord
  belongs_to :user
  belongs_to :rally
  belongs_to :driver1, class_name: "Driver"
  belongs_to :driver2, class_name: "Driver"
  belongs_to :car
  belongs_to :engineer
  belongs_to :sponsor

  validate :within_budget

  def calculate_cost
    (driver1&.price || 0) + (driver2&.price || 0) + (car&.price || 0) + (engineer&.price || 0)
  end

  private

  def within_budget
    if calculate_cost > user.budget
      errors.add(:base, "Exceeds total budget")
    end
  end
end
RUBY
)
