class Engineer < ApplicationRecord
  enum specialty: { engine: 0, aero: 1, suspension: 2, mechanics: 3 }
end
