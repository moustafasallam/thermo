module DataFinders
  class StatsFetcher

    def initialize(thermostat, sql_data)
      @sql_data = sql_data
      @redis_client = RedisClient.new(thermostat)
      @redis_data = get_redis_data
    end

    def get
      merger = StatsMerger.new(@sql_data, @redis_data)
      merger.results
    end

    private

    def get_redis_data
      data = []
      keys = @redis_client.get_all_keys
      keys.each do |k|
        data << @redis_client.get_by_key(k)
      end
      data
    end

  end
end