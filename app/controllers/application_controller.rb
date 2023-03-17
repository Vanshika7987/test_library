class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameter, if: :devise_controller?

  protected

  def configure_permitted_parameter
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[role name phone_number])
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
