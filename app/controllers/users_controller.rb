class UsersController < ApplicationController

  before_action :authenticate_user!

  def index
    @user = current_user
    @users = User.all
    @book = Book.new
  end

  def show
     @user = User.find(params[:id])
     @books = @user.books.all
     @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "User was successfully updated!"
      redirect_to user_path(@user.id)
    else
      flash.now[:danger] = "error"
      render 'users/edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
