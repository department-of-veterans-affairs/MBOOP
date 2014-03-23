class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  # Workaround because cancan doesn't support Rails 4
  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end
  # end of workaround
  
  def after_sign_in_path_for(user)
    folders_path
  end
  
  #rescue_from CanCan::AccessDenied do |exception|
  #  redirect_to root_url, :alert => exception.message
  #end
  
  protected

    def configure_permitted_parameters
       devise_parameter_sanitizer.for(:sign_up) { |u| 
          u.permit(:email, :password, :password_confirmation, :display_name, :current_password) 
       }
       devise_parameter_sanitizer.for(:account_update) { |u| 
           u.permit(:email, :password, :password_confirmation, :display_name, :current_password) 
        }
    end
end
