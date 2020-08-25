class BookCommentsController < ApplicationController
  before_action :authenticate_user!
  def create
  	# book = Book.find(params[:book_id])
  	# #本を一冊指定
   #  comment = current_user.book_comments.new(book_comment_params)
   #  #ログインしたユーザーの入力されたbook_commentsをcommentに代入
   #  comment.book_id = book.id
   #  # ?????　　それぞれのbookに投稿されたcommentsをbook_comentsとしてbookに関連づけて保存するためにidを同じにしている？
   #  comment.save
   #  redirect_to book_path(book)
    book = Book.find(params[:book_id])
    book_comment = current_user.book_comments.new(book_comment_params)
    book_comment.book_id = book.id
    if book_comment.save
      flash[:success] = "Comment was successfully created."
    end
    redirect_to request.referer
  end
end

  def destroy
    @book = Book.find(params[:book_id])
    book_comment = current_user.book_comments.find_by(id: params[:id], book_id: @book.id)
    book_comment.destroy
    redirect_to request.referer
    # redirect_to book_path(params[:book_id])
    # if  book_id.user == current_user
    #     book_comment.destroy
    #     redirect_to book_path(params[:book_id])
    # else
    #     @book = Book.find(params[:id])
    #     @user = @book.user
    #     @book_new = Book.new
    #     @book_comment = BookComment.new
    #     redirect_to book_path(book)
    # end
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:comment,:user_id)
  end
end
