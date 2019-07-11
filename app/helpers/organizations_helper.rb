module OrganizationsHelper
  def organizations_dropdown_menu(f)
    f.collection_select :organization_id, Organization.all, :id, :name
  end
end
