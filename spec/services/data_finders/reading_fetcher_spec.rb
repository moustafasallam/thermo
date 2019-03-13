require 'rails_helper'

describe DataFinders::ReadingFetcher do

  let(:thermo) {create(:thermostat, :with_readings)}

  it "gets the readings json data" do
    fetcher = DataFinders::ReadingFetcher.new(thermo, thermo.readings.first)
    json = fetcher.get_reading(thermo.readings.first.number)
    expect(json).to have_key(:temperature)
    expect(json).to have_key(:humidity)
    expect(json).to have_key(:battery_charge)
  end

  it "handles nil readings" do
    fetcher = DataFinders::ReadingFetcher.new(thermo, nil)
    expect {fetcher.get_reading(rand(1..100))}.to raise_error(DataFinders::Exceptions::DataFetchingFailure)
  end

end