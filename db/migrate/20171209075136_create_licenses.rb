class CreateLicenses < ActiveRecord::Migration[5.1]
  def change
    create_table :licenses do |t|
      t.string :content
      t.integer :is_used
      t.integer :position_id
      t.integer :license_type
      t.string :desc
      t.timestamps
    end
  end
end
