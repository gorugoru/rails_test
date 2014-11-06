class SessionsController < ApplicationController
  def new
    @user = User.new
  end
  def create
    session.clear
    remember_me = false
    if params[:user][:remember_me].present? and params[:user][:remember_me] == true
      remember_me = true
    end
    username = params[:user][:username]
    password = params[:user][:password]
    user = login(username, password, remember_me)

    #if user
    if session[:user_id].present?
      redirect_back_or_to root_url, :notice => "ログインしました　"
    else
      flash.now.alert = "メールアドレス/ユーザ名、もしくはパスワードを確認してください"
      @user = User.new
      render :new
    end
  end
end
