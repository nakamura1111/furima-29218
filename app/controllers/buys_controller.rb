class BuysController < ApplicationController
  before_action :move_to_login
  def index
    @good = Good.find(params[:good_id])
  end

  def create
    @good = Good.find(params[:good_id])
    @buy_info = BuyInfo.new(buy_params)
    if @buy_info.valid?                 # 自分で定義したsaveメソッドだと自動バリデーションは行ってくれないので、まずはバリデーションする。
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

  def buy_params
    params.permit(
      :postal_code,:addr_prefecture_id, :addr_municipality,
      :addr_house_number, :addr_building, :tel_number,
      :good_id, :token
    ).merge(user_id: current_user.id, price: @good.price)
  end
end
