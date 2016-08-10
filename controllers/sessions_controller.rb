require_relative '../lib/controller_base'
require_relative 'application_controller'

class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(username: params["user"]["username"],
                                     password: params["user"]["password"])
    if @user
      login!(@user)
      redirect_to (just_logged_in_url)
    else
      @user = User.new
      render :new
    end
  end

  def destroy
    logout!
    redirect_to (new_session_url)
  end

  private

  def new_session_url
    "http://localhost:#{@port}/session/new"
  end

  def just_logged_in_url
    "http://localhost:#{@port}/cats"
  end
end
