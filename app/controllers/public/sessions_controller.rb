# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
 before_action :configure_permitted_parameters

  def after_sign_in_path_for(resource)
    root_path
  end

 def guest_sign_in
  user = User.guest
  sign_in user
  flash[:notice]='ゲストユーザーとしてログインしました'
  redirect_to root_path
 end

 protected

 def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password])
 end

end
