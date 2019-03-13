module Api::V1
	class ReadingsController < Api::BaseController
		skip_before_action :verify_authenticity_token, only: [:create]
    before_action :get_thermostat

		def show
      @reading = Reading.where(thermostat_id: @thermostat.id).where(number: params[:id]).first
      fetcher = DataFinders::ReadingFetcher.new(@thermostat, @reading)
      success(fetcher.get_reading(params[:id]))
    end

		def create
      hash = reading_params.merge({number: @thermostat.update_counter})
      AddNewReadingJob.perform_later(hash, @thermostat.id)
      r_client = ::DataFinders::RedisClient.new(@thermostat)
      r_client.set(hash)
      success({number: hash[:number]})
		end

    def stats
      data = @thermostat.fetch_stats.as_json.first
      stats_fetcher = DataFinders::StatsFetcher.new(@thermostat, data)
      success(stats_fetcher.get)
    end

    private

    def get_thermostat
      @thermostat = Thermostat.find_by!(household_token: params[:household_token])
    end

    def reading_params
      params.require(:reading).permit(:temperature, :humidity, :battery_charge)
    end

	end
end