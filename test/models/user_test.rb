require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User",
                     email: "user@example.com",
                     password: "password",
                     password_confirmation: "password",
                     postcode1: "123",
                     postcode2: "4567")
    @bob = users(:bob)
    @alice = users(:alice)
  end

  test "user is valid" do
    assert @user.valid?
  end

  test "郵便番号が正しいフォーマットである" do
    invalid_postcodes = [["1234", "567"], ["1234", "5678"], ["a23", "4567"], ["123", "a567"]]
    invalid_postcodes.each do |invalid_postcode|
      @user.postcode1, @user.postcode2 = invalid_postcode
      assert_not @user.valid?
    end
  end

  test "ユーザーは別のユーザーをフォローできる" do
    assert_not @bob.following?(@alice)
    @bob.follow(@alice)
    assert @bob.following?(@alice)
    assert @alice.followers.include?(@bob)
  end

  test"フォロー済みユーザーのフォロー解除ができる" do
    @bob.follow(@alice)
    assert @bob.following?(@alice)
    @bob.unfollow(@alice)
    assert_not @bob.following?(@alice)
  end
end
