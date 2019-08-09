# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  acts_as_token_authentication_handler_for User, fallback: :none

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:user_name])
  end

  def admin_only!
    render file: 'public/403.html', status: :forbidden unless User.find(current_user.id)&.is_admin
  end
end
