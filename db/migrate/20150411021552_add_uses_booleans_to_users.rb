class AddUsesBooleansToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uses_electricity, :boolean
    add_column :users, :uses_water, :boolean
    add_column :users, :uses_natural_gas, :boolean
  end
end
