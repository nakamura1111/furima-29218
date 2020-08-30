class GoodsController < ApplicationController
  before_action :move_to_login, except: [:index]

  def index
    
  end

  def new
    @good = Good.new()
  end

  def create
    if Good.create(good_params)
      redirect_to root_path
    else
      render :new
    end
  end

  private
  
  def move_to_login
    unless user_signed_in?
      redirect_to(new_user_session_url)
    end
  end

  def good_params
    params.require(:good).permit(
      :name, :description, :category_id,
      :status_id, :price, :origin_prefecture_id,
      :delivery_days_id, :fee_charger_id, :image
    ).merge(user_id: current_user.id)
  end
end
