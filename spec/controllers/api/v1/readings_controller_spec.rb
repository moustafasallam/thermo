require 'rails_helper'


RSpec.describe Api::V1::ReadingsController, type: :controller do
  render_views
  let(:reading) {create(:reading)}

  describe "GET show" do
    before :example do
      get :show, params: { id: reading.number, household_token: reading.thermostat.household_token, format: :json }
    end

    it "check vars" do
      expect(assigns(:reading)).to eq(reading)
      expect(assigns(:thermostat)).to eq(reading.thermostat)
    end

    it "successful response" do
      expect(response.status).to eq(200)
    end

    it "repsonse has json content" do
      expect(response.content_type).to eq "application/json"
    end
  end

  describe "POST create" do
    before :example do
      post :create, params: { household_token: reading.thermostat.household_token, format: :json,
                          reading: {temperature: reading.temperature, humidity: reading.humidity, batter_charge: reading.battery_charge} }
    end

    it "check vars" do
      expect(assigns(:thermostat)).to eq(reading.thermostat)
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
      get :stats, params: { household_token: reading.thermostat.household_token, format: :json }
    end

    it "check vars" do
      expect(assigns(:thermostat)).to eq(reading.thermostat)
    end

    it "successful response" do
      expect(response.status).to eq(200)
    end

    it "repsonse has json content" do
      expect(response.content_type).to eq "application/json"
    end
  end

end