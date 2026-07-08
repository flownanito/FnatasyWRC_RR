class AddLeagueToFantasyLineups < ActiveRecord::Migration[7.0]
  def change
    add_reference :fantasy_lineups, :league, null: false, foreign_key: true
  end
end
