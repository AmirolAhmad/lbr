class CreateTeamOfficials < ActiveRecord::Migration
  def change
    create_table :team_officials do |t|
      t.string :name
      t.string :position
      t.string :phone_number
      t.string :ic_number
      t.string :email_address, unique: true
      t.belongs_to :teamoffable, polymorphic: true

      t.timestamps null: false
    end
    add_index :team_officials, [:teamoffable_id, :teamoffable_type]
  end
end
