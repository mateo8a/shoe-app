class AddVoidToShoes < ActiveRecord::Migration[5.2]
  def change
    add_column :shoes, :void, :boolean, default: false
  end
end
