require 'rails_helper'


RSpec.describe "readings api", type: :request do

  let(:reading) {create(:reading)}

  describe "GET show" do

    context "with correct params" do
      before :example do
        get "/api/v1/readings/#{reading.number}/?household_token=#{reading.thermostat.household_token}"
      end

      it "successful response" do
        expect(response.status).to eq(200)
      end

      it "repsonse has json content" do
        expect(response.content_type).to eq "application/json"
      end
    end

    context "with wrong params" do
      before :example do
        get "/api/v1/readings/#{reading.number}/?household_token=invalid"
      end

      it "expect to raise error as household_token is no valid" do
        expect(response.status).to eq(404)
      end
    end
  end

  describe "POST create" do
    before :example do
      post "/api/v1/readings/?household_token=#{reading.thermostat.household_token}",
      params: { reading: {temperature: reading.temperature, humidity: reading.humidity, batter_charge: reading.battery_charge} }
    end

    it "successful response" do
      expect(response.status).to eq(200)
    end

    it "repsonse has json content" do
      expect(response.content_type).to eq "application/json"
    end
  end


  describe "GET stats" do
    before :example do
      get "/api/v1/readings/stats/?household_token=#{reading.thermostat.household_token}"
    end

    it "successful response" do
      expect(response.status).to eq(200)
    end

    it "repsonse has json content" do
      expect(response.content_type).to eq "application/json"
    end
  end

end