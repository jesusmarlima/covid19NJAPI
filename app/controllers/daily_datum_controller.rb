class DailyDatumController < ApplicationController
  def today
    data =
      {dailyData: DailyDatum.where("STRFTIME('%Y-%m-%d', date) == '#{(DateTime.yesterday).to_date}'")}
    render json: data
  end
end
