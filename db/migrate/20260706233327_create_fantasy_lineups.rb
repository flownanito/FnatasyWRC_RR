class CreateFantasyLineups < ActiveRecord::Migration[7.0]
  def change
    create_table :fantasy_lineups do |t|
      t.references :user, null: false, foreign_key: true
      t.references :rally, null: false, foreign_key: true
      t.integer :driver1_id
      t.integer :driver2_id
      t.references :car, null: false, foreign_key: true
      t.references :engineer, null: false, foreign_key: true
      t.references :sponsor, null: false, foreign_key: true
      t.integer :total_score

      t.timestamps
    end
  end
end
