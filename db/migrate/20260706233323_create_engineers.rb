class CreateEngineers < ActiveRecord::Migration[7.0]
  def change
    create_table :engineers do |t|
      t.string :name
      t.integer :specialty
      t.decimal :price
      t.decimal :bonus_multiplier

      t.timestamps
    end
  end
end
