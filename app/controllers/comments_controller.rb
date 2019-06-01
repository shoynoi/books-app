class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to @comment.commentable, notice: "コメントを投稿しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to @comment.commentable, notice: "コメントを更新しました"
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to @comment.commentable, notice: "コメントを削除しました"
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:description, :commentable_id, :commentable_type)
  end
end
