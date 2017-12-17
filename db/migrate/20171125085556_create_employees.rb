class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :desc
      t.integer :publish_status
      t.integer :position_id
      t.float :score
      t.timestamps
    end
  end
end
