class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  #CRLLL
  #C current_user 
  #R require_logged_in
  #L login(user)
  #L logout
  #L logged_in?

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def require_logged_in
    redirect_to new_session_url if current_user.nil?
  end

  def login(user)
    @current_user = user
    session[:session_token] = user.reset_session_token!
  end

  def logout
    current_user.reset_session_token! if logged_in?
    session[:session_token] = nil
    @current_user = nil
  end

  def logged_in?
    !!current_user
  end

end
