class CreateThermostats < ActiveRecord::Migration[6.0]
  def change
    create_table :thermostats do |t|
      t.text :household_token
      t.index :household_token, unique: true
      t.text :location, default: ''
      t.integer :counter, default: 0
      t.timestamps
    end
  end
end
