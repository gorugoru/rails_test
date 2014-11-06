class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def current_user

    if @current_user.present?
      #すでに取得済みの場合はそれ使う
      return @current_user
    end

    user_id = nil

    begin
      # これではうまくいかないはず
      if session[:user_id].present?
        user_id = session[:user_id].to_s
      end

      # 下記で解決
      if session[:user_id]['$oid'].present?
        user_id = session[:user_id]['$oid'].to_s
      end

      #以下は、ねんのため。
      if session[:user_id]['$oid']['$oid'].present?
        user_id = session[:user_id]['$oid']['$oid'].to_s
      end

    rescue

    end

    if user_id.present?
      @current_user = User.where(:id => user_id).first
      if @current_user
        @current_user.id = user_id
        session[:current_user] = @current_user
      end
      @current_user
    end
  end

end
