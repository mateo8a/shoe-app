class ChangeShoesPhoneToBigInt < ActiveRecord::Migration[5.2]
  def change
    change_column :shoes, :phone, :bigint
  end
end
