class AddNewReadingJob < ApplicationJob
  queue_as :default

  def perform(data, thermostat_id)
    ActiveRecord::Base.transaction do
      thermostat = Thermostat.find(thermostat_id)
      reading = Reading.create!({
        thermostat_id: thermostat.id,
        number: data[:number],
        temperature: data[:temperature],
        humidity: data[:humidity],
        battery_charge: data[:battery_charge]
      })
      r_client = DataFinders::RedisClient.new(thermostat)
      r_client.remove(reading.number)
    end
  end
end
