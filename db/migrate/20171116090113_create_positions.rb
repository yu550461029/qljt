class CreatePositions < ActiveRecord::Migration[5.1]
  def change
    create_table :positions do |t|
      t.string :name
      t.string :desc
      t.integer :publish_status
      t.integer :team_id
      t.integer :position_type
      t.timestamps
    end
  end
end
