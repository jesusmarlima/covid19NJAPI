class DailyDatumController < ApplicationController
  def today
    data =
      {dailyData: DailyDatum.where("to_char(date,'YYYY-MM-DD') = '#{(DateTime.yesterday)}'")}
    render json: data
  end
end
