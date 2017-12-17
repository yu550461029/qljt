class CreatePositionEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :position_employees do |t|
      t.integer :postion_id
      t.integer :employee_id
      t.timestamps
    end
  end
end
