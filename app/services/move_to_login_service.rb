class MoveToLoginService
  def self.move_to_login
    redirect_to(new_user_session_url) unless user_signed_in?
  end
end