class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :phone_number])
  end

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_path
    when EndUser
      flash[:welcome] = "#{current_end_user.last_name} さん、ようこそ"
      end_user_path(current_end_user.id)
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :end_user
      root_path
    elsif resource_or_scope == :admin
      new_admin_session_path
    end
  end

  # def after_sign_out_path_for(resource)
  #   case resource
  #   when Admin
  #     new_admin_session_path
  #   when EndUser
  #     root_path
  #   end
  # end
end