class CreateTeamOfficials < ActiveRecord::Migration
  def change
    create_table :team_officials do |t|
      t.string :name
      t.string :position
      t.belongs_to :teamable, polymorphic: true

      t.timestamps null: false
    end
    add_index :team_officials, [:teamable_id, :teamable_type]
  end
end
