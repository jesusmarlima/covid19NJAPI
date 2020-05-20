class DailyDatumController < PrivateController

  def today
    data = {dailyData: DailyDatum.where(date: DailyDatum.select('MAX(date)')).sort_by{|d| d.owner }}
    render json: data
  end
  def state
    data =
      {dailyData: DailyDatum.where(owner: "NJ").sort_by{|d| [d.date ,d.owner] }}
    render json: data
  end

  def essex
    data =
      {dailyData: DailyDatum.where(owner: "Essex").sort_by{|d| [d.date ,d.owner] }}
    render json: data
  end

  def all
    data =
      {dailyData: DailyDatum.all.sort_by{|d| [d.date ,d.owner]}}
    render json: data
  end

  def growth
    owner = params[:owner]
    calculated = []
    data = DailyDatum.where(owner: owner).sort_by{|d| [d.date ,d.owner] }
    data.each_with_index do | daily, index |
      calculated << { day: index, value: calculate_growth(daily, data, index) }
    end
    data = {dailyData: calculated[0..calculated.length-2]}
    render json: data
  end

  private

  def calculate_growth(daily, data, index)
    x = data[index + 1].present? ? data[index + 1].positive.to_f : 0.to_f
    val = (x - daily.positive.to_f) / daily.positive.to_f
    (val*100).truncate(2)
  end
end