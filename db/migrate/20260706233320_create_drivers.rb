class CreateDrivers < ActiveRecord::Migration[7.0]
  def change
    create_table :drivers do |t|
      t.string :name
      t.integer :category
      t.decimal :price

      t.timestamps
    end
  end
end
