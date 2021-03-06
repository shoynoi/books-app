class BooksController < ApplicationController
  before_action :set_book, only: [:edit, :update, :destroy]

  # GET /books
  def index
    @books = Book.page(params[:page])
  end

  # GET /books/1
  def show
    @book = Book.find(params[:id])
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  def create
    @book = current_user.books.new(book_params)

    if @book.save
      redirect_to @book, notice: t("flash.create", resource: t("activerecord.models.book"))
    else
      render :new
    end
  end

  # PATCH/PUT /books/1
  def update
    if @book.update(book_params)
      redirect_to @book, notice: t("flash.update", resource: t("activerecord.models.book"))
    else
      render :edit
    end
  end

  # DELETE /books/1
  def destroy
    @book.destroy
    redirect_to books_url, notice: t("flash.destroy", resource: t("activerecord.models.book"))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = current_user.books.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def book_params
      params.require(:book).permit(:title, :memo, :author, :picture)
    end
end
