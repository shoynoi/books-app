require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase

  def setup
    user = users(:bob)
    sign_in(user)
    @book = books(:book)
  end

  test "書籍一覧が表示される" do
    visit books_path(locale: :ja)
    assert_selector "h1", text: "書籍一覧"
  end

  test "書籍の作成ができる" do
    visit new_book_path(locale: :ja)
    fill_in "タイトル", with: "example title"
    fill_in "メモ", with: "example memo"
    fill_in "著者", with: "example author"
    attach_file("画像", "test/fixtures/maru.png")
    click_button "登録"
    assert_text "書籍を作成しました"
  end

  test "書籍の更新ができる" do
    visit edit_book_path(@book, locale: :ja)
    fill_in "タイトル", with: "update title"
    fill_in "メモ", with: "update memo"
    fill_in "著者", with: "update author"
    click_button "更新する"
    assert_text "書籍を更新しました"
  end

  test "自身の登録した書籍の削除ができる" do
    visit books_path(locale: :ja)
    click_link "削除", href: book_path(@book, locale: :ja)
    page.driver.browser.switch_to.alert.accept
    assert_text "書籍を削除しました"
  end
end
