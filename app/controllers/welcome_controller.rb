class WelcomeController < ApplicationController
  def index
    @games = Game.order(:id.asc).page(params[:page])
  end

  def tos
    @user = User.where(:id => 'aaaa').first
    @user.save
  end

  def policy
  end

  def about
  end

  def test
    redirect_to '/', :alert => 'alert!!!'
  end
end
