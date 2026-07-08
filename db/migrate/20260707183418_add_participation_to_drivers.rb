class AddParticipationToDrivers < ActiveRecord::Migration[7.0]
  def change
    add_column :drivers, :participation, :integer
  end
end
