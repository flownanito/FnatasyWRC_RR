class CreateLeagueMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :league_members do |t|
      t.references :user, null: false, foreign_key: true
      t.references :league, null: false, foreign_key: true
      t.integer :total_points

      t.timestamps
    end
  end
end
