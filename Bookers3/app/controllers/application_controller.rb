class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	# devise_controllerは行われる前にconfigure_permitted_parametersが実行される。

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:email])
  end


  # before_action :authenticate_user!, except: [:top_action]
  def after_sign_in_path_for(resource)
  user_path(current_user.id) # ログイン後に遷移するpathを設定
  end

  def after_sign_out_path_for(resource)
  root_path # ログアウト後に遷移するpathを設定
  end

before_action :authenticate_user!
  def authenticate
  　 redirect_to root_path unless user_signed_in?
  end
end
