class ChangeMonthOnUser < ActiveRecord::Migration
  def up
		change_column :stats, :month, :integer
  end

  def down
		change_column :stats, :month, :string
  end
end
