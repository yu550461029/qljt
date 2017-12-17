class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :desc
      t.integer :publish_status
      t.integer :parent_team_id
      t.integer :team_type
      t.timestamps
    end
  end
end
