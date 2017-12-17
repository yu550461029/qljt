class CreateScores < ActiveRecord::Migration[5.1]
  def change
    create_table :scores do |t|
      t.string :position_id
      t.integer :score
      t.integer :license_id
      t.timestamps
    end
  end
end
