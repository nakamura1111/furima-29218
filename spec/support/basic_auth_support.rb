module BasicAuthSupport
  def basic_login
    user = ENV['BASIC_AUTH_USER']
    pw = ENV['BASIC_AUTH_PASSWORD']
    ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
  end
end