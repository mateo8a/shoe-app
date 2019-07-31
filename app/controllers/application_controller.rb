class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def check_if_user_has_organization
    if current_user
      render "users/organization_required" unless current_user.organization
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end

  private

  def require_admin
    raise StandardError.new("Not an admin") unless current_user.admin?
  end
end
