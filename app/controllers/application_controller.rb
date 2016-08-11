require_relative '../../lib/rails_lite/controller_base'

class ApplicationController < ControllerBase
  self.protect_from_forgery

  def login!(user)
    session[:session_token] = user.reset_session_token!
  end

  def logout!
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def current_user
    @current_user ||= User.where(session_token: session["session_token"]).first
  end

  def require_signed_in
    redirect_to ('http://localhost:3000/session/new') unless current_user
  end

  private

  def new_user_url
    "http://localhost:#{@port}/cats"
  end

  def new_session_url
    "http://localhost:#{@port}/session/new"
  end

  def just_logged_in_url
    "http://localhost:#{@port}/cats"
  end

end
