class UsersController < ApplicationController
	skip_before_action :authenticate_user!, only: [:top, :about]
	def top
	end

	def about
	end

	def show
        @book = Book.new
        @user = User.find(params[:id])
        # @user = User.find(params[:id])
        # if id == nil
        # @user = current_user
        @books = @user.books
        # @books = books.user
	end

	def edit
		@user = User.find(params[:id])
	    if @user != current_user
           redirect_to user_path(current_user)
        end
	end

	def index
		@users = User.all
        @book = Book.new
	end

	def update
		 @user = User.find(params[:id])
      if @user.update(user_params)
      	 flash[:notice] =  "Book was successfully updated."
         redirect_to user_path(@user)
      else
         render("users/edit")
    end
	end

	private
def user_params
  params.require(:user).permit(:name, :profile_image, :introduction)
end
def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end
end

