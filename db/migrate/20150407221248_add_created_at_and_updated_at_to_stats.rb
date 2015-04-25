class AddCreatedAtAndUpdatedAtToStats < ActiveRecord::Migration
  def change
    add_column :stats, :created_at, :datetime
    add_column :stats, :updated_at, :datetime
  end
end
