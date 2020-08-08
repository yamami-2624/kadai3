class BooksController < ApplicationController
before_action :authenticate_user!

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user = current_user
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book)
    else
      @books = Book.all
      render("books/index")
    end
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
       render "edit"
    else
       redirect_to books_path
    end
  end


  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      flash[:notice] =  "Book was successfully updated."
      redirect_to book_path(book)
    else
      @book = book
      render("books/edit")
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:notice] = "Book was successfully destroyed."
    redirect_to books_path
  end


  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def user_params
  params.require(:user).permit(:name, :introduction, :profile_image)
  end
end

