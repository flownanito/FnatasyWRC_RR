class CreateStages < ActiveRecord::Migration[7.0]
  def change
    create_table :stages do |t|
      t.references :rally, null: false, foreign_key: true
      t.string :name
      t.decimal :length_km
      t.string :surface_type

      t.timestamps
    end
  end
end
