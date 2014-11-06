class RegistrationsController < ApplicationController
  # ユーザ登録画面
  def new
    if current_user
      # すでにログインしてたら、マイページに飛ばす
      redirect_to '/me' and return
    end
    @user = User.new
  end

  # ユーザ登録処理
  def create
    if current_user
      # すでにログインしてたら、マイページに飛ばす
      redirect_to '/me' and return
    end

    # ユーザ入力した特定パラメータだけを使ってUserインスタンス作成
    @user = User.new(user_param)

    # 認証していないメアドを格納しておきます。（オプショナル)
    @user.email_unconfirmed = params[:user][:email]
    # 認証用トークン作成＆格納(オプショナル)
    token = SecureRandom.hex(10)
    @user.confirmation_token = token

    if params[:user][:password].blank?
      # パスワード入力がない場合
      # 注意: validation 使ってないのでスマートじゃない。
      redirect_to '/register', :alert => "パスワードを入力してください "  and return
    elsif @user.save
      # user保存できたら

      # ログイン処理
      login(@user.username, params[:user][:password])

      # 認証用URL作成
      confirm_uri = '/confirm/' + @user.id.to_s + '/' + token

      begin
        #  メール送信処理 => これは後で作成するのでコメントアウトしておいてください。
        # SimpleMailer.sendmail_registration(@user.email, confirm_uri, @user.username).deliver()
      rescue
        # メール送信失敗。。。
        redirect_to root_url, :alert => '登録しました。が、メール送信失敗。。。' and return
      end

      # 登録OKなので、マイページに飛ばしましょう。
      redirect_to '/me' , :notice => "登録しました。 "  and return
    end
    # 登録失敗？
    @user = User.new
    render :new and return
  end

  # ユーザが指定した特定のパラメーターだけを抽出するメソッド ( StrongParametersって言います。ますアサインメント脆弱性でググってみてください)
  def user_param
    params.require(:user).permit(:username, :email, :password)
  end

end
