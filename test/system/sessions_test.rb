require "application_system_test_case"

class SessionsTest < ApplicationSystemTestCase

  def setup
    @user = users(:bob)
  end

  test "ログイン/ログアウトができる" do
    visit user_session_path(locale: :ja)
    fill_in "Eメール", with: @user.email
    fill_in "パスワード", with: "password"
    click_button "ログイン"
    assert_text "ログインしました。"
    click_link "ログアウト"
    assert_text "ログアウトしました。"
  end

  test "Eメールとパスワードが一致しないとログインできない" do
    visit user_session_path(locale: :ja)
    fill_in "Eメール", with: "wrong@example.com"
    fill_in "パスワード", with: "wrongpass"
    click_button "ログイン"
    assert_text "Eメールまたはパスワードが違います。"
  end
end
