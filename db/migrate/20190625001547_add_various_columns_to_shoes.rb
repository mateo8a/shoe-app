class AddVariousColumnsToShoes < ActiveRecord::Migration[5.2]
  def change
    add_column :shoes, :product_type, :string
    add_column :shoes, :brand, :string
    add_column :shoes, :gender, :string
    add_column :shoes, :task_description, :text
    add_column :shoes, :paid_for, :boolean, default: false
    add_column :shoes, :location, :string
  end
end
