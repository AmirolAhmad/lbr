class CreateStateConfigs < ActiveRecord::Migration
  def change
    create_table :state_configs do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :state, index: true, foreign_key: true
      t.integer :count

      t.timestamps null: false
    end
  end
end
