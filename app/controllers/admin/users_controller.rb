class Admin::UsersController < Admin::BaseController
  # show, edit, destroy, updateのときだけ、set_userメソッドを事前に呼び出す。indexの時は呼び出さない
  before_action :set_user, :only => [:show, :edit, :destroy, :update]

  def index
    # １００件だけ取ってくる。条件なし。
    @users = User.all.limit(100)
  end

  def show
    # set_userでユーザを取得しているので特別処理必要なし。
    # 一応ユーザがいない時だけ、一覧ページに飛ばす処理いれとく。
    if @user.blank?
      redirect_to '/admin/users' and return  
    end
  end

  def edit

    # set_userでユーザを取得しているので特別処理必要なし。
    # 一応ユーザがいない時だけ、一覧ページに飛ばす処理いれとく。
    if @user.blank?
      redirect_to '/admin/users' and return  
    end
  end

  def update

    if @user.blank?
      redirect_to '/admin/users' and return 
    end
    if @user.update(user_params)
      redirect_to '/admin/users/' + @user.id.to_s, :notice => '編集しました'  and return 
    end

    # 編集失敗したのでeditページを表示しなおす
    render :edit

  end

  def destroy
    if @user.blank?
      redirect_to '/admin/users' and return
    end
    if @user.destroy
      redirect_to '/admin/users/', :notice => '削除しました'  and return
    end

    redirect_to '/admin/users/', :notice => '削除に失敗しました'  and return

  end 

  def set_user
    @user = User.where(:id => params[:id]).first
  end
  def user_params
    # ストロングパラメーターでメアドだけのポストを受け付ける
    params.require(:user).permit(:email)
  end
end
