class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :state, index: true, foreign_key: true
      t.string :team_name, unique: true
      t.string :team_ref_id, unique: true
      t.integer :admin_officer_id, index: true
      t.string :phone_number
      t.string :team_email_address, unique: true
      t.text :address
      t.string :team_logo
      t.string :team_image
      t.integer :status

      t.timestamps null: false
    end
  end
end
