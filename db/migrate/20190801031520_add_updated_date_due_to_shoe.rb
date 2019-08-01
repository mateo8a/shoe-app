class AddUpdatedDateDueToShoe < ActiveRecord::Migration[5.2]
  def change
    add_column :shoes, :updated_date_due, :datetime
  end
end
