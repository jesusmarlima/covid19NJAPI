class CreateDailyData < ActiveRecord::Migration[6.0]
  def change
    create_table :daily_data do |t|
      t.datetime :date
      t.string :owner
      t.integer :positive
      t.string :negative
      t.integer :deaths

      t.timestamps
    end
  end
end
