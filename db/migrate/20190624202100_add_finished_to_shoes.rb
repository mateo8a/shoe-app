class AddFinishedToShoes < ActiveRecord::Migration[5.2]
  def change
    add_column :shoes, :finished, :boolean, default: false
  end
end
