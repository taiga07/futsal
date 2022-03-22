class ApplicationController < ActionController::Base
  
  # viewでもcontrollerのメソッドを使用できるように
  # helper_methodを
  helper_method :current_user

  private

  def current_user
    if session[:user_id]  #true = ログイン状態
       # ||=　変数に値がなければ代入する
       @current_user ||= User.find_by(id: session[:user_id])
    end
  end

end
