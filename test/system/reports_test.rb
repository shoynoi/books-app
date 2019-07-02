require "application_system_test_case"

class ReportsTest < ApplicationSystemTestCase

  def setup
    user = users(:bob)
    sign_in(user)
    @report = reports(:report)
  end

  test "日報一覧が表示される" do
    visit reports_path
    assert_selector "h1", text: "日報一覧"
  end

  test "日報の作成ができる" do
    visit new_report_path
    fill_in "タイトル", with: "example title"
    fill_in "作業日", with: I18n.l(Date.today)
    fill_in "内容", with: "example description"
    click_button "登録する"
    assert_text "日報を作成しました"
  end

  test "日報の更新ができる" do
    visit edit_report_path(@report)
    fill_in "タイトル", with: "update title"
    fill_in "作業日", with: I18n.l(Date.today)
    fill_in "内容", with: "update description"
    click_button "更新する"
    assert_text "日報を更新しました"
  end

  test "自身の登録した日報の削除ができる" do
    visit reports_path
    click_link "削除", href: report_path(@report)
    page.driver.browser.switch_to.alert.accept
    assert_text "日報を削除しました"
  end
end
