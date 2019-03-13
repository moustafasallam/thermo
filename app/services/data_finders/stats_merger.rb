module DataFinders
  class StatsMerger

    KEYS = ['temperature', 'humidity', 'battery_charge']

    def initialize(sql_data, redis_data)
      @sql_data = sql_data || {}
      @redis_data = redis_data
      @data = @sql_data.dup
    end

    def results
      return @sql_data if @redis_data.blank?
      @transformed_redis_data = transform_redis_data
      merge_all
      @data
    end

    private

    #done that way in order to avoid more than one loop
    def transform_redis_data
      hash = {'sum_temperature' => 0.0, 'sum_humidity' => 0.0, 'sum_battery_charge' => 0.0}
      @redis_data.each do |r|
        hash['sum_temperature'] += r['temperature'].to_f
        hash['sum_humidity'] += r['humidity'].to_f
        hash['sum_battery_charge'] += r['battery_charge'].to_f
        hash['max_temperature'] = r['temperature'].to_f if hash['max_temperature'].nil? || r['temperature'].to_f > hash['max_temperature']
        hash['max_humidity'] = r['humidity'].to_f if hash['max_humidity'].nil? || r['humidity'].to_f > hash['max_humidity']
        hash['max_battery_charge'] = r['battery_charge'].to_f if hash['max_battery_charge'].nil? || r['battery_charge'].to_f > hash['max_battery_charge']
        hash['min_temperature'] = r['temperature'].to_f if hash['min_temperature'].nil? || r['temperature'].to_f < hash['min_temperature']
        hash['min_humidity'] = r['humidity'].to_f if hash['min_humidity'].nil? || r['humidity'].to_f < hash['min_humidity']
        hash['min_battery_charge'] = r['battery_charge'].to_f if hash['min_battery_charge'].nil? || r['battery_charge'].to_f < hash['min_battery_charge']
      end
      hash
    end

    def merge_all
      merge_avg
      merge_max
      merge_min
      merge_total
    end

    def merge_avg
      KEYS.each do |key|
        @data["avg_#{key}"] = ((@data["avg_#{key}"] * @data["total_count"]) + @transformed_redis_data["sum_#{key}"]) / (@data['total_count'] + @redis_data.size)
      end
    end

    def merge_max
      KEYS.each do |key|
        @data["max_#{key}"] = @transformed_redis_data["max_#{key}"] if @transformed_redis_data["max_#{key}"] > @data["max_#{key}"]
      end
    end

    def merge_min
      KEYS.each do |key|
        @data["min_#{key}"] = @transformed_redis_data["min_#{key}"] if @transformed_redis_data["min_#{key}"] < @data["min_#{key}"]
      end
    end

    def merge_total
      @data['total_count'] += @redis_data.size
    end

  end
end