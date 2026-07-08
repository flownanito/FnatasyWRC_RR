class CreateOfficialDriverResults < ActiveRecord::Migration[7.0]
  def change
    create_table :official_driver_results do |t|
      t.references :rally, null: false, foreign_key: true
      t.references :driver, null: false, foreign_key: true
      t.integer :position
      t.integer :points_earned

      t.timestamps
    end
  end
end
