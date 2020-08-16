class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]
  # ログインしていないユーザーを弾く
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    redirect_to user_path(current_user) if @user != current_user
    # != 右と左が等しくなければ
    # if @user == current_user
    #   render 'edit'
    # else
    #   redirect_to user_path(@user)
    # end
  end

  def update
  @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

   def ensure_correct_user
     @user = User.find(params[:id])
     unless @user == current_user
       # @userがログインしたユーザーでなければ
       redirect_to user_path(current_user)
     end
     #ログインしていないユーザーがアクセスした時の行き場所を指定
   end
end
