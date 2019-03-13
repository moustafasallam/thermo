module DataFinders
  class ReadingFetcher

    def initialize(thermostat, reading)
      @thermostat = thermostat
      @reading = reading
    end

    def get_reading(number)
      if @reading.blank?
        r_client = RedisClient.new(@thermostat)
        @reading = r_client.get_by_number(number)
      end
      raise Exceptions::DataFetchingFailure, 'Failed to locate required data!' if @reading.blank?
      get_json
    end

    private


    def get_json
      {
        temperature: @reading['temperature'],
        humidity: @reading['humidity'],
        battery_charge: @reading['battery_charge'],
        number: @reading['number']
      }
    end

  end
end