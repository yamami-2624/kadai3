# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i(top about)
  def top; end

  def about; end

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
    redirect_to user_path(current_user) if @user != current_user
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'Book was successfully updated.'
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
