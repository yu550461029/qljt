class AddEntityIdToPositionRelationship < ActiveRecord::Migration[5.1]
  def change
    add_column :position_relationships, :entity_id, :integer
    add_column :position_relationships, :relationship_type, :integer
    add_column :position_relationships, :position_id, :integer
  end
end
