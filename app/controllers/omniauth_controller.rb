class OmniauthController < ApplicationController
  skip_before_action :authenticate_user!
  def localized
    session[:omniauth_login_locale] = I18n.locale
    omniauth_authorize_path = if params[:provider] == "github"
      user_github_omniauth_authorize_path
    else
      new_session_path
    end
    redirect_to omniauth_authorize_path
  end
end
