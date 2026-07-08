class AddMetricsToDrivers < ActiveRecord::Migration[7.0]
  def change
    add_column :drivers, :image_url, :string
    add_column :drivers, :overall_rating, :integer
    add_column :drivers, :pace, :integer
    add_column :drivers, :consistency, :integer
    add_column :drivers, :experience, :integer
  end
end
