class CreateReadings < ActiveRecord::Migration[6.0]
  def change
    create_table :readings do |t|

      t.references :thermostat, index: false
      t.integer    :number, default: 0
      t.index      [:thermostat_id, :number], unique: true
      t.float      :temperature, default: 0.0
      t.float      :humidity, default: 0.0
      t.float      :battery_charge, default: 0.0

      t.timestamps
    end
  end
end
