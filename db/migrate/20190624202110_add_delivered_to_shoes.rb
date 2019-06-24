class AddDeliveredToShoes < ActiveRecord::Migration[5.2]
  def change
    add_column :shoes, :delivered, :boolean, default: false
  end
end
