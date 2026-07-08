class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.string :model_name
      t.decimal :price
      t.integer :performance_bonus

      t.timestamps
    end
  end
end
