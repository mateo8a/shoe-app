class AddIdWithinOrganizationToShoes < ActiveRecord::Migration[5.2]
  def change
    add_column :shoes, :id_within_organization, :integer, :null => false
  end
end
