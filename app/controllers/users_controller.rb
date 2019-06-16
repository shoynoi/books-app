class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).with_attached_avatar
  end

  def show
    @user = User.find(params[:id])
  end
end
