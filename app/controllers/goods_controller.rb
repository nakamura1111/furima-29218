class GoodsController < ApplicationController
  before_action :move_to_login, except: [:index, :show]
  before_action :current_good,  only: [:show, :destroy]

  def index
    @goods = Good.all.order('created_at DESC')
  end

  def new
    @good = Good.new
  end

  def create
    @good = Good.new(good_params)
    if @good.save
      redirect_to root_path
    else
      render :new
    end
  end

  # profit_calcアクション(売却時利益と手数料算出の非同期通信)
  def profit_calc
    price = params.require(:price).to_i
    profit = price * 0.9
    sales_fee = price * 0.1
    render json: { post: { profit: profit.to_i, sales_fee: sales_fee.to_i } }
  end

  def show
  end

  def destroy
    @good.destroy if current_user == @good.user
    redirect_to root_path
  end

  private

  def move_to_login
    redirect_to(new_user_session_url) unless user_signed_in?
  end

  def good_params
    params.require(:good).permit(
      :name, :description, :category_id,
      :status_id, :price, :origin_prefecture_id,
      :delivery_days_id, :fee_charger_id, :image
    ).merge(user_id: current_user.id)
  end

  def current_good
    @good = Good.find(params[:id])
  end
end
