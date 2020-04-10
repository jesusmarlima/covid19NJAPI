class DailyDatumController < ApplicationController
  def today
    data =
      {dailyData: DailyDatum.where("to_char(date,'YYYY-MM-DD') = '#{(DateTime.yesterday)}'")}
    render json: data
  end
  def state
    data =
      {dailyData: DailyDatum.where(owner: "NJ")}
    render json: data
  end

  def essex
    data =
      {dailyData: DailyDatum.where(owner: "Essex")}
    render json: data
  end

  def all
    data =
      {dailyData: DailyDatum.all}
    render json: data
  end

end
