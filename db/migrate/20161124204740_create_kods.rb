class CreateKods < ActiveRecord::Migration
  def change
    create_table :kods do |t|
      t.string :kod_number
      t.string :kod_name

      t.timestamps null: false
    end
  end
end
