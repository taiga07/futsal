class SessionsController < ApplicationController

  def new
  end

  def create
    # ログイン画面で入力されたアドレスでユーザー情報を探す
    user = User.find_by(email: session_params[:email])
    
    # 送られてきたパスワードによる認証をauthenticateメソッドを使って行う
    if user&.authenticate(session_params[:password])
      # 認証に成功できた場合、セッションにuser_idを格納する
      session[:user_id] = user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    reset_session  #セッション情報を削除
    redirect_to root_path
  end



  private

  def session_params
    params.permit(:email, :password)
  end


end
