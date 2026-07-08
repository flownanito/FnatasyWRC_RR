class Car < ApplicationRecord
  belongs_to :team, optional: true
end
