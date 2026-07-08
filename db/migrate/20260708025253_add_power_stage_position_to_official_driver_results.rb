class AddPowerStagePositionToOfficialDriverResults < ActiveRecord::Migration[7.0]
  def change
    add_column :official_driver_results, :power_stage_position, :integer
  end
end
