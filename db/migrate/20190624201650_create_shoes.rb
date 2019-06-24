class CreateShoes < ActiveRecord::Migration[5.2]
  def change
    create_table :shoes do |t|
      t.string :color
      t.date :date_received
      t.date :date_due
      t.string :owner
      t.integer :phone
      t.string :type_of_payment
      t.decimal :cost

      t.timestamps
    end
  end
end
