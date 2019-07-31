class AddForeignKeyColumnsToProductTypeTable < ActiveRecord::Migration[5.2]
  def change
    add_reference :product_types, :organization, index: true, foreign_key: true
  end
end
