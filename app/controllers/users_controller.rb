require_relative 'application_controller'

class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    # owner_id = User.where()
    @user = User.new(username: params["user"]["username"],
                     password: params["user"]["password"],
                     session_token: SecureRandom.urlsafe_base64(16))
    if @user.save
      login!(@user)
      redirect_to (new_user_url)
    else
      render :new
    end
  end

  def show
    unless current_user
      redirect_to new_session_url
    else
      @user = User.find(params["id"].to_i)
      render :show
    end
  end

end
