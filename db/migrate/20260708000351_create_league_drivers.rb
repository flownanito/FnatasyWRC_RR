class CreateLeagueDrivers < ActiveRecord::Migration[7.0]
  def change
    create_table :league_drivers do |t|
      t.references :league, null: false, foreign_key: true
      t.references :driver, null: false, foreign_key: true
      t.references :user, null: true, foreign_key: true
      t.decimal :release_clause

      t.timestamps
    end
  end
end
