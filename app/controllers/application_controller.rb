class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end

  private

  def require_admin
    raise StandardError.new("Not an admin") unless current_user.admin?
  end

  def param_to_boolean(param)
    ActiveRecord::Type::Boolean.new.deserialize(param)
  end
end
