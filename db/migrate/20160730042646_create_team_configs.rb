class CreateTeamConfigs < ActiveRecord::Migration
  def change
    create_table :team_configs do |t|
      t.belongs_to :state, index: true, foreign_key: true
      t.integer :count

      t.timestamps null: false
    end
  end
end
