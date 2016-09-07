class CreateTeamOfficials < ActiveRecord::Migration
  def change
    create_table :team_officials do |t|
      t.belongs_to :team, index: true, foreign_key: true
      t.string :name
      t.string :position
      t.string :phone_number
      t.string :ic_number
      t.string :email_address, unique: true
      t.string :no_sijil
      t.string :salinan_sijil

      t.timestamps null: false
    end
  end
end
