class AddUpdateDueDateToShoes < ActiveRecord::Migration[5.2]
  def change
    add_column :shoes, :update_date_due, :boolean, default: false
  end
end
