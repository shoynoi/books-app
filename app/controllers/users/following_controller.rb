class Users::FollowingController < ApplicationController
  def index
    @following = User.find(params[:user_id]).following.with_attached_avatar.order("friendships.updated_at DESC").page(params[:page])
  end
end
