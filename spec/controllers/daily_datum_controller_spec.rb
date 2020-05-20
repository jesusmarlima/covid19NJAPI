require 'rails_helper'

describe DailyDatumController do

  describe 'Unauthorized requests' do
    it 'should return 401' do
      get :today
      expect(response.status).to eq(401)
    end
  end

  describe "authenticated requests" do

    before(:each) {
      allow(controller).to receive(:authenticate_request!).and_return(true)
    }

    it 'should return dailydata array of dailydata' do
      expected = {dailyData:[DailyDatum.create(owner:"Essex",date: DateTime.current, negative:100, positive:100, deaths:2)]}.to_json
      get :today
      expect(response.body).to eq(expected)
    end

    it 'should return dailydata array all data' do
      expected = {
        dailyData:[
          DailyDatum.create(owner:"Essex",date: DateTime.current, negative:100, positive:100, deaths:2),
          DailyDatum.create(owner:"NJ",date: DateTime.current, negative:1000, positive:1000, deaths:10)]
      }.to_json
      get :all
      expect(response.body).to eq(expected)
    end

    it 'should return only Essex data' do
      DailyDatum.create(owner:"NJ",date: DateTime.current, negative:1000, positive:1000, deaths:10)
      expected = { dailyData:[
        DailyDatum.create(owner:"Essex",date: DateTime.current, negative:100, positive:100, deaths:2),
        DailyDatum.create(owner:"Essex",date: DateTime.current, negative:1000, positive:100, deaths:2)]
      }.to_json
      get :essex
      expect(response.body).to eq(expected)
    end

    it 'should return only NJ data' do
      expected = { dailyData:[ DailyDatum.create(owner:"NJ",date: DateTime.current, negative:1000, positive:1000, deaths:10)]}.to_json
      DailyDatum.create(owner:"Essex",date: DateTime.current, negative:100, positive:100, deaths:2)
      DailyDatum.create(owner:"Essex",date: DateTime.current, negative:1000, positive:100, deaths:2)
      get :state
      expect(response.body).to eq(expected)
    end

    it 'should return dailydata growth Essex' do
      DailyDatum.create(owner:"Essex",date: DateTime.current, negative:100, positive:100, deaths:2)
      DailyDatum.create(owner:"NJ",date: DateTime.current, negative:1000, positive:1000, deaths:10)
      growth = {dailyData:[{day:0, value:-100.0}]}.to_json
      get :growth_essex
      expect(response.body).to eq(growth)
    end

    it 'should return dailydata growth NJ' do
      DailyDatum.create(owner:"NJ",date: DateTime.yesterday - 1, negative:100, positive:100, deaths:2)
      DailyDatum.create(owner:"NJ",date: DateTime.yesterday, negative:100, positive:100, deaths:2)
      DailyDatum.create(owner:"NJ",date: DateTime.current, negative:1000, positive:1000, deaths:10)
      growth = {dailyData:[{day:0, value:0.0},{day:1, value:900.0} ]}.to_json
      get :growth_nj
      expect(response.body).to eq(growth)
    end
  end
end
