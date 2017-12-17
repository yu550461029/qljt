class AddPublishStatusToLicense < ActiveRecord::Migration[5.1]
  def change
    add_column :licenses, :publish_status, :integer
  end
end
