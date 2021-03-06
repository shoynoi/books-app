class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]

  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.new(comment_params)

    if @comment.save
      redirect_to @comment.commentable, notice: t("flash.create", resource: t("activerecord.models.comment"))
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to @comment.commentable, notice: t("flash.update", resource: t("activerecord.models.comment"))
    else
      render :edit
    end
  end

  def destroy
    commentable = @comment.commentable
    @comment.destroy
    redirect_to commentable, notice: t("flash.destroy", resource: t("activerecord.models.comment"))
  end

  private

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:description, :commentable_id, :commentable_type)
  end
end
