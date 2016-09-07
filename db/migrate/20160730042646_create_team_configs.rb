class CreateTeamConfigs < ActiveRecord::Migration
  def change
    create_table :team_configs do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :state, index: true, foreign_key: true
      t.string :team_name

      t.timestamps null: false
    end
  end
end
