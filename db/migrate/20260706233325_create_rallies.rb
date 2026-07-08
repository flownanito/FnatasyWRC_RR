class CreateRallies < ActiveRecord::Migration[7.0]
  def change
    create_table :rallies do |t|
      t.string :name
      t.string :country
      t.integer :surface
      t.integer :status

      t.timestamps
    end
  end
end
