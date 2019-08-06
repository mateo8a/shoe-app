module OrganizationsHelper
  def organizations_dropdown_menu(f)
    html_options = current_user.admin? ? {} : { disabled: true }
    f.collection_select :organization_id, Organization.all, :id, :name, {}, html_options
  end
end
