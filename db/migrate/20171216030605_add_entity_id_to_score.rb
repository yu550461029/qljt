class AddEntityIdToScore < ActiveRecord::Migration[5.1]
  def change
    add_column :scores, :entity_id, :string
    add_column :scores, :entity_type, :string
  end
end
