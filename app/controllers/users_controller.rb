class UsersController < ApplicationController
  # before_action :ensure_correct_user, only: [:update, :edit] # :editを記述することによって、[26. 他ユーザーのプロフィールを編集できないようにする]ことができる
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :authenticate_user! # 答え エラーが出たら消す

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
  end

  def update
    if @user.update(user_params)
      # redirect_to user_path(@user.id), notice: "You have updated user successfully."
      # redirect_to users_path(@user), notice: "You have updated user successfully."
      redirect_to @user, notice: "You have updated user successfully."
      # [15. プロフィール編集が成功した後] URLを見てみるとhttps://...amazonaws.com/users.1 となっていますが、/users.1となることは不適切
      # だから users_path(@user)を@userに修正した。
    else
      # render "show"
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
      redirect_to books_path　# 答え
      # redirect_to user_path(current_user)
    end
  end
end
