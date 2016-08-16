class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :team_name
      t.string :team_ref_id
      t.belongs_to :state, index: true, foreign_key: true
      t.text :address
      t.belongs_to :user, index: true, foreign_key: true
      t.string :team_logo
      t.string :team_image
      t.integer :status, default: 0

      t.timestamps null: false
    end
  end
end
