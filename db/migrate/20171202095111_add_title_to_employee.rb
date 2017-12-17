class AddTitleToEmployee < ActiveRecord::Migration[5.1]
  def change
    add_column :employees, :level, :string
    add_column :employees, :gender, :string
    add_column :employees, :identification, :string
    add_column :employees, :age, :integer
  end
end
