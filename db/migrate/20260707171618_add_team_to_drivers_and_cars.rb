class AddTeamToDriversAndCars < ActiveRecord::Migration[7.0]
  def change
    add_reference :drivers, :team, null: true, foreign_key: true
    add_reference :cars, :team, null: true, foreign_key: true
  end
end
