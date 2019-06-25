class FriendshipsController < ApplicationController
  def create
    user = User.find(params[:friendship][:followed_id])
    current_user.follow(user)
    redirect_to user_path(user), notice: t("friendships.flash.create")
  end

  def destroy
    user = Friendship.find(params[:id]).followed
    current_user.unfollow(user)
    redirect_to user_path(user), notice: t("friendships.flash.destroy")
  end
end
