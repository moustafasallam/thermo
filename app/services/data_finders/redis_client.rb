require "redis"

module DataFinders
  class RedisClient

    REDIS_DB = 3

    def initialize(thermostat)
      @thermostat = thermostat
      @redis = Redis.new(db: REDIS_DB)
    end


    def set(hash)
      @redis.set(get_key(hash[:number]), hash.to_json)
    end

    def get_by_number(number)
      data = @redis.get(get_key(number))
      JSON.parse(data) if data.present?
    end

    def get_by_key(key)
      data = @redis.get(key)
      JSON.parse(data) if data.present?
    end

    def get_all_keys
      @redis.scan(0, match: "thermostat_#{@thermostat.id}_*")[1]
    end

    def remove(number)
      data = @redis.get(get_key(number))
      @redis.del(get_key(number)) if data.present?
    end

    private

    def get_key(number)
      "thermostat_#{@thermostat.id}_#{number}"
    end

  end
end