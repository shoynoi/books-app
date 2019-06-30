require "application_system_test_case"

class FollowingsTest < ApplicationSystemTestCase
  def setup
    @user = users(:bob)
    @other_user = users(:alice)
    sign_in @user
  end

  test "ユーザーをフォローできる" do
    visit user_path(@other_user, locale: :ja)
    assert_difference "@user.following.count", 1 do
      click_button "フォロー"
      assert_text "フォローしました"
    end
  end

  test "ユーザーをフォロー解除できる" do
    visit user_path(@other_user, locale: :ja)
    click_button "フォロー"
    assert_difference "@user.following.count", -1 do
      click_button "フォロー解除"
      assert_text "フォロー解除しました"
    end
  end

  test "フォロー一覧にフォローしたユーザーが表示されている" do
    visit user_path(@other_user, locale: :ja)
    click_button "フォロー"
    visit user_path(@user, locale: :ja)
    click_link "フォロー中"
    @user.following.each do |user|
      assert has_link?(user.name)
    end
  end

  test "フォロワー一覧にフォローされているユーザーが表示されている" do
    visit user_path(@other_user, locale: :ja)
    click_button "フォロー"
    click_link "フォロワー"
    @other_user.followers.each do |user|
      assert has_link?(user.name)
    end
  end
end
