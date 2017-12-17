class AddWeightToPositions < ActiveRecord::Migration[5.1]
  def change
    add_column :positions, :weight, :float
  end
end
