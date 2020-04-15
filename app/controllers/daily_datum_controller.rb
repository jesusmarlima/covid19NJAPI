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

  def growthNJ
    njs_calculated = []
    njs = DailyDatum.where(owner: "NJ")
    njs.each_with_index do | daily, index |
      x = njs[index + 1].present? ? njs[index + 1].positive.to_f : 0.to_f
      val =  (x - daily.positive.to_f) / daily.positive.to_f
      njs_calculated << { day: index, value: (val*100).truncate(2) }
    end
    data = {dailyData: njs_calculated[0..njs_calculated.length-2]}

    render json: data
  end

  def growthEssex
    essex_calculated = []
    essex = DailyDatum.where(owner: "Essex")
    essex.each_with_index do | daily, index |
      x = essex[index + 1].present? ? essex[index + 1].positive.to_f : 0.to_f
      val =  (x - daily.positive.to_f) / daily.positive.to_f
      essex_calculated << { day: index, value: (val*100).truncate(2) }
    end
    data = {dailyData: essex_calculated[0..essex_calculated.length-2]}

    render json: data
  end

end
