require 'rails_helper'

RSpec.describe Reading, type: :model do

  let(:reading) {create(:reading)}

  describe "testing model behaviour" do

    it "reading gets created!" do
      expect(reading).not_to be_nil
      expect(reading.thermostat).not_to be_nil
    end

    it { is_expected.to belong_to(:thermostat) }

  end

end
