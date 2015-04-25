class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.integer :electricity_usage
      t.integer :water_usage
      t.integer :natural_gas_usage
      t.string :month
      t.integer :year
      t.integer :user_id
    end
  end
end
