class CreatePositionRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :position_relationships do |t|

      t.timestamps
    end
  end
end
