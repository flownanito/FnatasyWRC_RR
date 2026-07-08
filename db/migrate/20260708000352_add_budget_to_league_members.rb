class AddBudgetToLeagueMembers < ActiveRecord::Migration[7.0]
  def change
    add_column :league_members, :budget, :decimal, default: 100_000_000.0
  end
end
