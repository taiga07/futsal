class UsersController < ApplicationController

  before_action :user_login, only: [:edit, :update]
  before_action :set_futsal, only: [:edit, :update]
  before_action :prevent_url, only: [:edit, :update]

  # ユーザー新規登録画面
  def new
    @user = User.new
  end

  # 新規登録
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end



  private

  def user_params
    params.require(:user).permit(:name, :email, :introduction, :password, :password_confirmation)
  end

  # ログインしていないユーザーの利用制限
  def user_login
    unless current_user
      redirect_to root_path
    end
  end
  # ここまで

  # ログインユーザーのURL直打ち防止
  def set_futsal
    @user = User.find(params[:id])
  end

  def prevent_url
    if @user.id != current_user.id
      redirect_to root_path
    end
  end
  # ここまで

end
