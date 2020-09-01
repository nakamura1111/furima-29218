class BuysController < ApplicationController
  before_action :move_to_login
  def index
    @good = Good.find(params[:good_id])
  end

  private

  def move_to_login
    redirect_to(new_user_session_url) unless user_signed_in?
  end
end
