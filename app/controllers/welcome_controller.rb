class WelcomeController < ApplicationController
  def index
    @games = Game.order(:id.asc).page(params[:page])
  end

  def tos
  end

  def policy
  end

  def about
  end

  def test
    redirect_to '/', :alert => 'alert!!!'
  end
end
