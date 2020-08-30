class GoodsController < ApplicationController
  before_action :move_to_login, except: [:index]

  def index
    
  end

  def new
    @good = Good.new()
  end

  def create

  end

  private
  def move_to_login
    unless user_signed_in?
      redirect_to(new_user_session_url)
    end
  end
  
end
