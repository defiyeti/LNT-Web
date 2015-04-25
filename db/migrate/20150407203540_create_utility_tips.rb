class CreateUtilityTips < ActiveRecord::Migration
  def change
    create_table :utility_tips do |t|
      t.integer :order
      t.string :text
      t.integer :utility_id

      t.timestamps null: false
    end
  end
end
