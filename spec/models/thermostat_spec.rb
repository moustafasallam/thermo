require 'rails_helper'

RSpec.describe Thermostat, type: :model do

  let(:thermostat) {create(:thermostat)}

  describe "testing model behaviour" do
    it "test udpate counter" do
      counter = thermostat.counter
      thermostat.update_counter
      expect(thermostat.counter).to eq(counter + 1)
    end

    it { is_expected.to have_many(:readings) }

    it "fetch all related readings" do
      thermo = create(:thermostat, :with_readings)
      expect(thermo.fetch_stats.as_json).not_to be_empty
    end

    it "should have token" do
      expect(thermostat.household_token).not_to be_nil
    end
  end

end
