class BookCommentsController < ApplicationController
  before_action :authenticate_user!
  def create
  	book = Book.find(params[:book_id])
  	#本を一冊指定
    comment = current_user.book_comments.new(book_comment_params)
    #ログインしたユーザーの入力されたbook_commentsをcommentに代入
    comment.book_id = book.id
    # ?????　　それぞれのbookに投稿されたcommentsをbook_comentsとしてbookに関連づけて保存するためにidを同じにしている？
    comment.save
    redirect_to book_path(book)
  end

  def destroy
    book_comment = BookComment.find_by(id: params[:id], book_id: params[:book_id])
    book_comment.user == current_user
    if  book_comment.destroy
        redirect_to book_path(params[:book_id])
    else
        @book = Book.find(params[:id])
        @user = @book.user
        @book_new = Book.new
        @book_comment = BookComment.new
        render('books/show')
    end
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
