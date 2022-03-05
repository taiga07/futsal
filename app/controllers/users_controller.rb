class UsersController < ApplicationController

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

end
