class AddDeliveredDateToShoes < ActiveRecord::Migration[5.2]
  def change
    add_column :shoes, :delivered_date, :datetime
  end
end
