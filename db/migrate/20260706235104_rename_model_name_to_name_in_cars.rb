class RenameModelNameToNameInCars < ActiveRecord::Migration[7.0]
  def change
    rename_column :cars, :model_name, :name
  end
end
