require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase

  def setup
    @user = users(:bob)
    sign_in(@user)
  end

  test "書籍の詳細ページにコメント一覧が表示される" do
    book = books(:book)
    visit book_path(book)
    assert_selector "h2", text: "コメント"
  end

  test "書籍の詳細ページにコメントが投稿できる" do
    book = books(:book)
    visit book_path(book)
    fill_in "コメント", with: "Example Comment"
    click_button "登録する"
    assert_text "コメントを作成しました"
  end

  test "日報の詳細ページにコメントが表示される" do
    report = reports(:report)
    visit report_path(report)
    assert_selector "h2", text: "コメント"
  end

  test "日報の詳細ページにコメントが投稿できる" do
    report = reports(:report)
    visit report_path(report)
    fill_in "コメント", with: "Example Comment"
    click_button "登録する"
    assert_text "コメントを作成しました"
  end

  test "投稿したコメントが編集できる" do
    report = reports(:report)
    comments(:comment)
    visit report_path(report)
    within ".comment" do
      click_link "編集"
    end
    fill_in "コメント", with: "Update Comment"
    click_button "更新する"
    assert_text "コメントを更新しました"
  end

  test "投稿したコメントが削除できる" do
    report = reports(:report)
    comment = comments(:comment)
    visit report_path(report)
    within ".comment" do
      click_link "削除", href: comment_path(comment)
    end
    page.driver.browser.switch_to.alert.accept
    assert_text "コメントを削除しました"
  end

end
