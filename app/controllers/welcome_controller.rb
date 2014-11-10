class WelcomeController < ApplicationController
  def index
    @games = Game.order(:id.asc)
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
