class PostsController < ApplicationController

  before_action :user_login, only: [:new, :edit, :update, :destroy]
  before_action :set_futsal, only: [:edit, :update, :destroy]
  before_action :prevent_url, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = '投稿が完了しました'
      redirect_to posts_path
    else
      flash.now[:alert] = '投稿に失敗しました'
      render :new
    end
  end

  def index
    @user = current_user
    @posts = Post.all.order(created_at: :desc).page(params[:page]).per(10)

    if params[:search].present?
      @posts = Post.where('place LIKE ? or schedule LIKE ? or body LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%").page(params[:page]).per(10)
    end

  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = '内容を変更しました'
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end


  private

  def post_params
    params.require(:post).permit(:place, :schedule, :body, :contact)
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
    @post = Post.find(params[:id])
  end

  def prevent_url
    if @post.user_id != current_user.id
      redirect_to root_path
    end
  end
  # ここまで

end
