class CreateLeagues < ActiveRecord::Migration[7.0]
  def change
    create_table :leagues do |t|
      t.string :name
      t.string :code
      t.references :owner, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
