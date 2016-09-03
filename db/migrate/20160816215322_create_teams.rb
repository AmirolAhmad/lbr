class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :team_name, unique: true
      t.string :team_ref_id, unique: true
      t.integer :admin_officer_id, index: true
      t.integer :general_coordinator_id, index: true
      t.belongs_to :state, index: true, foreign_key: true
      t.string :phone_number
      t.string :team_email_address, unique: true
      t.text :address
      t.string :team_logo
      t.string :team_image
      t.integer :status
      t.belongs_to :teamable, polymorphic: true

      t.timestamps null: false
    end
    add_index :teams, [:teamable_id, :teamable_type]
  end
end
