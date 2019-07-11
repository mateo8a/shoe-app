module ApplicationHelper
  DEAFULT_HEADER_TITLE = "Shoe organization app"

  def header_title
    if current_user.try(:organization)
      current_user.organization.name
    else
      DEAFULT_HEADER_TITLE
    end
  end
end
