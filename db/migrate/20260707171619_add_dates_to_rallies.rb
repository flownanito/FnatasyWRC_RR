class AddDatesToRallies < ActiveRecord::Migration[7.0]
  def change
    add_column :rallies, :start_date, :date
    add_column :rallies, :end_date, :date
  end
end
