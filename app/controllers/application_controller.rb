class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :authenticate_user!
  after_action :verify_authorized, unless: :devise_controller?
  before_action :configure_permitted_parameter, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    return unless current_user.student?

    flash[:alert] = 'you are not authorized user'
    redirect_to(request.referrer || root_path)
  end

  protected

  def configure_permitted_parameter
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[role name phone_number country state city])
  end

  def after_sign_out_path_for(_resource_or_scope)
    users_path
  end

  def after_sign_in_path_for(_resource)

    if current_user.student?
      profile_students_path
    else
      profile_librarians_path

    end
  end
end
