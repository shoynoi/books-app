class Users::FollowersController < ApplicationController
  def index
    @followers = User.find(params[:user_id]).followers.with_attached_avatar.order("friendships.updated_at DESC").page(params[:page])
  end
end
