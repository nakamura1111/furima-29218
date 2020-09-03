class BuysController < ApplicationController
  before_action :move_to_login

  def index
    @buy_info = BuyInfo.new
    @pay_info = Credit.new
    @good = Good.find(params[:good_id])
    move_to_root
  end

  def create
    @good = Good.find(params[:good_id])
    @buy_info = BuyInfo.new(buy_params)
    @pay_info = Credit.new(credit_params)
    # 自作定義のsaveメソッドはバリデーションを行ってくれないので、バリデーションで条件分岐
    if @buy_info.valid? && @pay_info.valid? && !ENV['PAYJP_SECRET_KEY'].nil?
      @pay_info.save
      @buy_info.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def move_to_login
    redirect_to(new_user_session_url) unless user_signed_in?
  end

  def move_to_root
    redirect_to(root_url) if
      current_user == @good.user || !@good.buy_history.nil?
  end

  def buy_params
    params.permit(
      :postal_code, :addr_prefecture_id, :addr_municipality,
      :addr_house_number, :addr_building, :tel_number
    ).merge(user: current_user, good: @good)
  end

  def credit_params
    params.permit(:token).merge(price: @good.price)
  end
end
