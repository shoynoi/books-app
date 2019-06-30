require "application_system_test_case"

class RegistrationsTest < ApplicationSystemTestCase

  test "ユーザー登録ができる" do
    visit new_user_registration_path(locale: :ja)
    fill_in "ユーザー名", with: "username"
    fill_in "Eメール", with: "user@example.com"
    fill_in "user[postcode1]", with: "123"
    fill_in "user[postcode2]", with: "4567"
    fill_in "住所", with: "東京都町田市1-2-3"
    fill_in "自己紹介", with: "自己紹介です"
    fill_in "パスワード", with: "password"
    fill_in "パスワード（確認用）", with: "password"
    click_button "アカウント登録"
    assert_text "本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。"
    user = User.last
    token = user.confirmation_token
    visit user_confirmation_path(confirmation_token: token, locale: :ja)
    assert_text "アカウントを登録しました。"
  end

  test "ユーザー編集ができる" do
    user = users(:bob)
    sign_in(user)
    visit edit_user_registration_path(user, locale: :ja)
    fill_in "自己紹介", with: "自己紹介を更新しました"
    click_button "更新"
    assert_text "アカウント情報を変更しました。"
  end

  test "不正な値で更新はできない" do
    user = users(:bob)
    sign_in(user)
    visit edit_user_registration_path(user, locale: :ja)
    fill_in "ユーザー名", with: ""
    fill_in "Eメール", with: ""
    fill_in "パスワード", with: "foo"
    fill_in "パスワード（確認用）", with: "bar"
    click_button "更新"
    within "#error_explanation" do
      assert_text "Eメールを入力してください"
      assert_text "パスワード（確認用）とパスワードの入力が一致しません"
      assert_text "パスワードは6文字以上で入力してください"
      assert_text "ユーザー名を入力してください"
    end
  end
end
