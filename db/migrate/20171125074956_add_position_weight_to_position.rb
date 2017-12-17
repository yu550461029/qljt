class AddPositionWeightToPosition < ActiveRecord::Migration[5.1]
  def change
    add_column :positions, :position_weight, :float
    add_column :positions, :employee_weight, :float
  end
end
