class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.find_for_github_oauth(request.env["omniauth.auth"], current_user)
    I18n.locale = session[:omniauth_login_locale]

    if @user.persisted?
      set_flash_message(:notice, :success, kind: "GitHub") if is_navigational_format?
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.github_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
