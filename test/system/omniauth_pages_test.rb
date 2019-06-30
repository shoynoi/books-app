require "application_system_test_case"

class OmniauthPagesTest < ApplicationSystemTestCase

  def setup
    OmniAuth.config.mock_auth[:github] = nil
    Rails.application.env_config["omniauth.auth"] = set_omniauth
  end

  test "GitHub連携でサインアップする" do
    visit user_session_path
    assert_difference "User.count", 1 do
      click_link "GitHubでログイン"
      assert_text "GitHub アカウントによる認証に成功しました。"
    end
  end

  test "GitHub連携でサインインする" do
    visit user_session_path
    click_link "GitHubでログイン"
    click_link "ログアウト"
    assert_no_difference "User.count" do
      click_link "GitHubでログイン"
      assert_text "GitHub アカウントによる認証に成功しました。"
    end
  end
end
