class FavoritesController < ApplicationController
	before_action :authenticate_user!
  def create
  	book = Book.find(params[:book_id])
    favorite = current_user.favorite.new(book_id: book.id)
    favorite.save
    # redirect_to :back
    redirect_back(fallback_location: root_path)
  end

  def destroy
  	book = Book.find(params[:book_id])
    favorite = current_user.favorite.find_by(book_id: book.id)
    favorite.destroy
    # redirect_to :back
    redirect_back(fallback_location: root_path)
  end
end
