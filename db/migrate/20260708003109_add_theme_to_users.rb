class AddThemeToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :theme, :string, default: 'dark'
  end
end
