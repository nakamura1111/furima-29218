class GoodsController < ApplicationController
  before_action :move_to_login, except: [:index, :show, :search, :search_result]
  before_action :current_good,  only: [:show, :destroy, :edit, :update]
  before_action :search_good, only: [:search, :search_result]

  def index
    @goods = Good.order('created_at DESC').first(10)
  end

  def new
    @good = Good.new
  end

  def create
    @good = Good.new(good_params)
    if @good.save
      redirect_to root_path
    else
      @good.images = nil
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
    if current_user == @good.user && @good.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  def edit
    redirect_to(root_url) unless (current_user == @good.user && @good.buy_history == nil)
  end

  def update
    params[:images] = @good.images  if params[:images] == nil
    if @good.update(good_params)
      redirect_to action: "show", id: @good.id
    else
      render :edit
    end
  end

  def search
  end

  def search_result
    @results = @p.result#includes
  end

  private

  def move_to_login
    redirect_to(new_user_session_url) unless user_signed_in?
  end

  def good_params
    params.require(:good).permit(
      :name, :description, :category_id,
      :status_id, :price, :origin_prefecture_id,
      :delivery_days_id, :fee_charger_id, images: []
    ).merge(user_id: current_user.id)
  end

  def current_good
    @good = Good.find(params[:id])
  end
  # ransack専用の、検索に特化したオブジェクトを生成(カラムの末尾に検索方法を追記する)
  def search_good
    @p = Good.ransack(params[:q])
  end

  def set_good_column
    # @good_category = Good.select("category").distinct
  end
end
